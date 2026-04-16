-- +goose Up
-- +goose StatementBegin
CREATE TABLE IF NOT EXISTS companies (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS products (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    company_ids INT[]
);

CREATE TABLE IF NOT EXISTS qualities (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    description TEXT NOT NULL
);


CREATE TYPE claims_scope_enum AS ENUM ('company, product');
CREATE TYPE claims_polarity_enum AS ENUM ('positive', 'neutral', 'negative');

CREATE TABLE IF NOT EXISTS claims (
    id SERIAL PRIMARY KEY,
    code TEXT NOT NULL,
    name TEXT NOT NULL,
    description TEXT NOT NULL,
    scope claims_scope_enum NOT NULL,
    polarity claims_polarity_enum NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL,
    deleted_at TIMESTAMP NOT NULL
);

CREATE TYPE claim_instances_applies_enum as ENUM ('true', 'unsure', 'false');
CREATE TYPE claim_instances_confidence_enum as ENUM ('high', 'medium', 'low');

CREATE TABLE IF NOT EXISTS claim_instances (
    id SERIAL PRIMARY KEY,
    claim_id INT NOT NULL,
    product_id INT NOT NULL,
    company_id INT NOT NULL,
    trace_id INT NOT NULL,
    applies claim_instances_applies_enum NOT NULL,
    confidence claim_instances_confidence_enum NOT NULL
);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS companies;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS qualities;
DROP TYPE IF EXISTS claims_scope_enum;
DROP TYPE IF EXISTS claims_polarity_enum;
DROP TABLE IF EXISTS claims;
DROP TABLE IF EXISTS claim_instances;
-- +goose StatementEnd