CREATE SCHEMA golang_014;
ALTER SCHEMA golang_014 OWNER TO golang;

CREATE TYPE golang_014.Currency AS ENUM (
  'USD',
  'CAD',
  'EUR'
);

CREATE TABLE golang_014.accounts (
  "id" bigserial PRIMARY KEY,
  "owner" varchar NOT NULL,
  "balance" bigint NOT NULL,
  "currency" golang_014.Currency NOT NULL,
  "created_at" timestamptz NOT NULL DEFAULT (now())
);

CREATE TABLE golang_014.entries (
  "id" bigserial PRIMARY KEY,
  "account_id" bigint NOT NULL,
  "amount" bigint NOT NULL,
  "created_at" timestamptz NOT NULL DEFAULT (now())
);

CREATE TABLE golang_014.transfers (
  "id" bigserial PRIMARY KEY,
  "from_account_id" bigint NOT NULL,
  "to_account_id" bigint NOT NULL,
  "amount" bigint NOT NULL,
  "created_at" timestamptz NOT NULL DEFAULT (now())
);

ALTER TABLE golang_014.entries ADD FOREIGN KEY ("account_id") REFERENCES golang_014.accounts ("id");

ALTER TABLE golang_014.transfers ADD FOREIGN KEY ("from_account_id") REFERENCES golang_014.accounts ("id");

ALTER TABLE golang_014.transfers ADD FOREIGN KEY ("to_account_id") REFERENCES golang_014.accounts ("id");

CREATE INDEX ON golang_014.accounts ("owner");

CREATE INDEX ON golang_014.entries ("account_id");

CREATE INDEX ON golang_014.transfers ("from_account_id");

CREATE INDEX ON golang_014.transfers ("to_account_id");

CREATE INDEX ON golang_014.transfers ("from_account_id", "to_account_id");

COMMENT ON COLUMN "golang_014"."entries"."amount" IS 'can be negative or positive';

COMMENT ON COLUMN "golang_014"."transfers"."amount" IS 'must be positive';
