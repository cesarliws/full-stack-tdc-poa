import React from "react";

import notify from "devextreme/ui/notify";
import Button from "devextreme-react/button";
import Popup from "devextreme-react/popup";
import { LoadIndicator } from "devextreme-react/load-indicator";

import "devextreme/dist/css/dx.common.css";
import "devextreme/dist/css/dx.light.css";

import { housesDataSource } from "./data.js";
import House from "./House.js";

import { formatCurrency } from "./numberFormat.js";

const ADD_TO_FAVORITES = "Adicionar aos Favoritos";
const REMOVE_FROM_FAVORITES = "Remover de Favoritos";

const favButtonAttrs = {
  class: "favorites"
};

class App extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      currentHouse: null,
      housesSource: [],
      isLoading: true,
      remoteDataSource: true,
      saveJsonData: false
    };
  }

  componentDidMount() {
    if (this.state.remoteDataSource)
      this.loadData();
    else {
      this.setLoadedData(housesDataSource)
    }
  }

  loadData = () => {
    this.setLoading(true);

    var houses = [];
    var agents = [];

    fetch("http://localhost:8080/api/houses/")
      .then(response => {
        if (response.ok) {
          response.json().then(data => {
            houses = data;

            fetch("http://localhost:8080/api/agents/")
              .then(response => {
                if (response.ok) {
                  response.json().then(data => {
                    agents = data;
                    this.mergeLoadedData(houses, agents);
                  });
                }
              })
              .catch(err => {
                notify("Erro ao consultar Agentes: " + err, "error", 2000);
                this.setLoading(false);
                console.log(err);
              });
          });
        }
      })
      .catch(err => {
        notify("Erro ao consultar Casas: " + err, "error", 2000);
        this.setLoading(false);
        console.log(err);
      });
  };

  setLoading = value => {
    this.setState({
      isLoading: value
    });
  };

  setLoadedData = (houses) => {
    this.setState({
      housesSource: houses,
      currentHouse: houses[0]
    });

    this.setLoading(false);
  }

  mergeLoadedData = (houses, agents) => {
    houses.forEach(house => {
      let agent = agents.filter(agent => agent.id === house.agentid);
      if (agent) house.agent = agent[0];
    })

    if (this.state.saveJsonData){
      this.download(JSON.stringify(houses), "./data.json", "text/json")
    }

    this.setLoadedData(houses)
  };

  download = (content, fileName, contentType) => {
    var a = document.createElement("a");
    var file = new Blob([content], { type: contentType });
    a.href = URL.createObjectURL(file);
    a.download = fileName;
    a.click();
  };

  render() {
    const housesSource = this.state.housesSource;
    const currentHouse = this.state.currentHouse;
    const isLoading = this.state.isLoading;

    return (
      <div>
        <LoadIndicator
          id={"large-indicator"}
          height={60}
          width={60}
          visible={isLoading}
        />
        {!isLoading && housesSource && (
          <div className={"images"}>
            {housesSource.map(h => (
              <House house={h} show={this.showHouse} key={h.id} />
            ))}
            {currentHouse && (
              <Popup
                width={660}
                height={540}
                showTitle={true}
                title={currentHouse ? currentHouse.address : ""}
                dragEnabled={false}
                closeOnOutsideClick={true}
                visible={this.state.popupVisible}
                onHiding={this.handlePopupHidden}
                contentRender={this.renderPopup}
              />
            )}
          </div>
        )}
      </div>
    );
  }

  renderPopup = () => {
    const currentHouse = this.state.currentHouse;
    return (
      <div className="simulators Web light">
        <div className="demo-device">
          <div className="demo-display">
            <div className="load-panel" style={{ display: "none" }} />
            <div className={"popup-property-details"}>
              <div className={"large-text"}>
                {formatCurrency(currentHouse.price)}
              </div>
              <div className={"opacity"}>
                {currentHouse.address}, {currentHouse.city},{" "}
                {currentHouse.state}
              </div>
              <Button
                icon={"favorites"}
                text={
                  currentHouse.favorite
                    ? REMOVE_FROM_FAVORITES
                    : ADD_TO_FAVORITES
                }
                width={210}
                height={44}
                elementAttr={favButtonAttrs}
                onClick={this.changeFavoriteState}
              />
              <div className={"images"}>
                <img src={currentHouse.image} alt="House" />
                <img
                  src={currentHouse.image.replace(".jpg", "b.jpg")}
                  alt="House"
                />
              </div>
              <div>{currentHouse.features}</div>
            </div>
          </div>
        </div>
      </div>
    );
  };

  showHouse = house => {
    this.setState({
      currentHouse: house,
      popupVisible: true
    });
  };

  handlePopupHidden = () => {
    this.setState({
      popupVisible: false
    });
  };

  async postFavorite(houseid, favorite) {
    fetch(`http://localhost:8080/api/houses/${houseid}`, {
      method: "POST",
      headers: {
        Accept: "application/json",
        "Content-Type": "application/json"
      },
      body: JSON.stringify({
        favorite: favorite
      })
    })
    .then(response => {
      if (!response.ok) {
        notify("Erro ao Salvar Casa em Favoritos: " + response.statusText, "error", 2000);
        console.log(response);
        }
    })
    .catch(err => {
      notify("Erro ao Salvar Casa em Favoritos: " + err, "error", 2000);
      console.log(err);
    });
  }

  changeFavoriteState = () => {
    const currentHouse = this.state.currentHouse;
    currentHouse.favorite = !currentHouse.favorite;
    this.postFavorite(currentHouse.id, currentHouse.favorite);

    this.setState({
      currentHouse
    });

    notify({
        message: `Este item foi ${currentHouse.favorite ? "adicionado a" : "removido da" } lista de Favoritos!`,
        width: 450
      },
      currentHouse.favorite ? "success" : "error",
      2000
    );
  };
}

export default App;
