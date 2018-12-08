-- Table: public."House"

-- DROP TABLE public."House";

CREATE TABLE public."House"
(
  "ID" bigint NOT NULL DEFAULT nextval('"House_ID_seq"'::regclass),
  "Favorite" boolean NOT NULL DEFAULT false,
  "Address" character varying(100) NOT NULL,
  "City" character varying(100) NOT NULL,
  "State" character varying(2) NOT NULL,
  "ZipCode" character varying(10) NOT NULL,
  "Beds" integer,
  "Baths" integer,
  "HouseSize" integer,
  "LotSize" numeric(18,2),
  "Price" money,
  "Coordinates" character varying(100) NOT NULL,
  "Features" text,
  "YearBuilt" integer,
  "Type" smallint,
  "Status" smallint,
  "Image" character varying(2000),
  CONSTRAINT "House_pkey" PRIMARY KEY ("ID")
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public."House"
  OWNER TO postgres;


-- Table: public."Agent"

-- DROP TABLE public."Agent";

CREATE TABLE public."Agent"
(
  "ID" bigint NOT NULL DEFAULT nextval('"Agent_ID_seq"'::regclass),
  "Name" character varying(100) NOT NULL,
  "Phone" character varying(100) NOT NULL,
  "Picture" character varying(2000),
  CONSTRAINT "Agent_pkey" PRIMARY KEY ("ID")
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public."Agent"
  OWNER TO postgres;


-- Table: public."AgentHouse"

-- DROP TABLE public."AgentHouse";

CREATE TABLE public."AgentHouse"
(
  "ID" bigint NOT NULL DEFAULT nextval('"AgentHouse_ID_seq"'::regclass),
  "AgentId" bigint NOT NULL,
  "HouseId" bigint NOT NULL,
  CONSTRAINT "AgentHouse_pkey" PRIMARY KEY ("ID"),
  CONSTRAINT fk_agente FOREIGN KEY ("AgentId")
      REFERENCES public."Agent" ("ID") MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_house FOREIGN KEY ("HouseId")
      REFERENCES public."House" ("ID") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public."AgentHouse"
  OWNER TO postgres;

-- Index: public.fki_agente

-- DROP INDEX public.fki_agente;

CREATE INDEX fki_agente
  ON public."AgentHouse"
  USING btree
  ("AgentId");

-- Index: public.fki_house

-- DROP INDEX public.fki_house;

CREATE INDEX fki_house
  ON public."AgentHouse"
  USING btree
  ("HouseId");


