import React from 'react';

import Popover from 'devextreme-react/popover';

import { formatCurrency } from "./numberFormat.js";

const position = {
    offset: '0, 2',
    at: 'bottom',
    my: 'top',
    collision: 'fit flip'
};

class House extends React.PureComponent {

    constructor(props) {
        super(props);

        this.show = this.show.bind(this);
        this.renderAgentDetails = this.renderAgentDetails.bind(this);
    }

    render() {
        const house = this.props.house;
        return (
        <div>
            <div onClick={this.show} className={'item-content'}>

            <img src={house.image} alt="House"/>

            <div className={'item-options'}>
                <div>
                <div className={'address'}>{house.address}</div>
                <div className={'price large-text'}>{formatCurrency(house.price)}</div>
                <div className={'agent'}>
                    <div id={`house${house.id}`}>
                        <img src={'images/icon-agent.svg'} alt="Agent" />
                        Agente
                    </div>
                </div>
                </div>
            </div>
            <Popover
                showEvent={'mouseenter'}
                hideEvent={'mouseleave'}
                position={position}
                target={`#house${house.id}`}
                width={260}
                contentRender={this.renderAgentDetails}
            />
            </div>
        </div>
        );
    }

    renderAgentDetails() {
        const agent = this.props.house.agent;
        return (
        <div className={'agent-details'}>
            <img src={agent.picture}  alt="Agent"/>
            <div>
            <div className={'name large-text'}>{agent.name}</div>
            <div className={'phone'}>Tel: {agent.phone}</div>
            </div>
        </div>
        );
    }

    show() {
        this.props.show(this.props.house);
    }
}

export default House;