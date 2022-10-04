--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'md5d925dc329c55c9b68011d2cdc1b67cfe';






--
-- Database creation
--

CREATE DATABASE keycloak WITH TEMPLATE = template0 OWNER = postgres;
REVOKE CONNECT,TEMPORARY ON DATABASE template1 FROM PUBLIC;
GRANT CONNECT ON DATABASE template1 TO PUBLIC;


\connect keycloak

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 10.21 (Debian 10.21-1.pgdg90+1)
-- Dumped by pg_dump version 10.21 (Debian 10.21-1.pgdg90+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE public.admin_event_entity OWNER TO postgres;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO postgres;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO postgres;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO postgres;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO postgres;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO postgres;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO postgres;

--
-- Name: client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO postgres;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    value character varying(4000),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_attributes OWNER TO postgres;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO postgres;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO postgres;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO postgres;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO postgres;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO postgres;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO postgres;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO postgres;

--
-- Name: client_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


ALTER TABLE public.client_session OWNER TO postgres;

--
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_auth_status OWNER TO postgres;

--
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_note OWNER TO postgres;

--
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_prot_mapper OWNER TO postgres;

--
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_role OWNER TO postgres;

--
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_user_session_note OWNER TO postgres;

--
-- Name: component; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO postgres;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(4000)
);


ALTER TABLE public.component_config OWNER TO postgres;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO postgres;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO postgres;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO postgres;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO postgres;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO postgres;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255)
);


ALTER TABLE public.event_entity OWNER TO postgres;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024)
);


ALTER TABLE public.fed_user_attribute OWNER TO postgres;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO postgres;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO postgres;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO postgres;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO postgres;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO postgres;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO postgres;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO postgres;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO postgres;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO postgres;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO postgres;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


ALTER TABLE public.identity_provider OWNER TO postgres;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO postgres;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO postgres;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO postgres;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36)
);


ALTER TABLE public.keycloak_group OWNER TO postgres;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO postgres;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO postgres;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL
);


ALTER TABLE public.offline_client_session OWNER TO postgres;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.offline_user_session OWNER TO postgres;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO postgres;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO postgres;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO postgres;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO postgres;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO postgres;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO postgres;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO postgres;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO postgres;

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO postgres;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO postgres;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO postgres;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO postgres;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO postgres;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO postgres;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO postgres;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO postgres;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO postgres;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO postgres;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode character varying(15) NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO postgres;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO postgres;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy character varying(20),
    logic character varying(20),
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO postgres;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO postgres;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO postgres;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO postgres;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO postgres;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO postgres;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO postgres;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL
);


ALTER TABLE public.user_attribute OWNER TO postgres;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO postgres;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO postgres;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO postgres;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO postgres;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO postgres;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO postgres;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO postgres;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO postgres;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO postgres;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO postgres;

--
-- Name: user_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


ALTER TABLE public.user_session OWNER TO postgres;

--
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE public.user_session_note OWNER TO postgres;

--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO postgres;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO postgres;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
0505f06f-ae83-4155-b2e3-f4da1051ac02	\N	auth-cookie	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	cc1793bb-b836-4e16-b06b-ea1840b0b2e2	2	10	f	\N	\N
12ce89dd-6430-45bf-860a-1c3bedc72e0d	\N	auth-spnego	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	cc1793bb-b836-4e16-b06b-ea1840b0b2e2	3	20	f	\N	\N
da811135-2068-47e1-8b3f-519abda776be	\N	identity-provider-redirector	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	cc1793bb-b836-4e16-b06b-ea1840b0b2e2	2	25	f	\N	\N
491edcd2-aa89-4158-b43c-6107979255cb	\N	\N	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	cc1793bb-b836-4e16-b06b-ea1840b0b2e2	2	30	t	99187b7f-e063-4fc2-85c8-41cc94a8bf8f	\N
bd7c77a7-1a27-4fd9-82f5-26c9a7c80b66	\N	auth-username-password-form	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	99187b7f-e063-4fc2-85c8-41cc94a8bf8f	0	10	f	\N	\N
2990d705-7c85-4d8b-9da0-3beab1464701	\N	\N	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	99187b7f-e063-4fc2-85c8-41cc94a8bf8f	1	20	t	9e834f36-885e-4ca8-b5a3-c35b8532f092	\N
54982b46-9486-4f80-aed8-0ac846a47d07	\N	conditional-user-configured	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	9e834f36-885e-4ca8-b5a3-c35b8532f092	0	10	f	\N	\N
4013fdcc-bc64-4721-b705-c352173e0315	\N	auth-otp-form	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	9e834f36-885e-4ca8-b5a3-c35b8532f092	0	20	f	\N	\N
326b869a-9e12-4c53-abd2-982b03e5a48a	\N	direct-grant-validate-username	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	256ebaa4-f0e3-4027-af03-6e8a9a1cc6fd	0	10	f	\N	\N
bfe5b58a-0a43-42c1-923f-6273d6b302d1	\N	direct-grant-validate-password	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	256ebaa4-f0e3-4027-af03-6e8a9a1cc6fd	0	20	f	\N	\N
5c71dc7b-6607-4ca9-81fa-6b5c481124ea	\N	\N	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	256ebaa4-f0e3-4027-af03-6e8a9a1cc6fd	1	30	t	b78ba4ee-578b-4444-b941-d2da62ad1ada	\N
1355b81a-3b48-4e7c-8374-809a6e5e20bd	\N	conditional-user-configured	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	b78ba4ee-578b-4444-b941-d2da62ad1ada	0	10	f	\N	\N
df614603-6d77-499f-a092-4fd738cab84a	\N	direct-grant-validate-otp	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	b78ba4ee-578b-4444-b941-d2da62ad1ada	0	20	f	\N	\N
8914ca0f-62de-49b6-b4b2-e2fb128f5dce	\N	registration-page-form	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	16836c02-fc4c-4f47-90eb-14e0a73884f1	0	10	t	d7d7550b-5981-4cda-8a81-444a09e74a59	\N
ba3ca57e-e32f-4b71-b5f3-19a4d1124bda	\N	registration-user-creation	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	d7d7550b-5981-4cda-8a81-444a09e74a59	0	20	f	\N	\N
7858d47c-627e-4e89-8930-902ee09f9a18	\N	registration-profile-action	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	d7d7550b-5981-4cda-8a81-444a09e74a59	0	40	f	\N	\N
50c78d34-434f-4f5b-b920-1dbcda61f660	\N	registration-password-action	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	d7d7550b-5981-4cda-8a81-444a09e74a59	0	50	f	\N	\N
b9c442f9-d51e-4db9-8655-a0f2dabc73f8	\N	registration-recaptcha-action	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	d7d7550b-5981-4cda-8a81-444a09e74a59	3	60	f	\N	\N
01796c15-e226-4ca2-920a-4525dc1c5f7f	\N	reset-credentials-choose-user	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	fea957fa-5886-45af-aaf5-22f124e3e865	0	10	f	\N	\N
039f5900-c325-4a06-b54a-e27a1f922976	\N	reset-credential-email	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	fea957fa-5886-45af-aaf5-22f124e3e865	0	20	f	\N	\N
63e77ce6-be29-423b-aa0b-a23dfb27a6e2	\N	reset-password	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	fea957fa-5886-45af-aaf5-22f124e3e865	0	30	f	\N	\N
44607a9a-a047-4b48-96f5-eb5e1d55b206	\N	\N	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	fea957fa-5886-45af-aaf5-22f124e3e865	1	40	t	4c52297d-b277-4eee-b436-85e4d4a7255e	\N
eb322551-93b5-4337-957b-5c1192877981	\N	conditional-user-configured	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	4c52297d-b277-4eee-b436-85e4d4a7255e	0	10	f	\N	\N
26d7718a-70bf-4cd0-bdc0-3f9c688327db	\N	reset-otp	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	4c52297d-b277-4eee-b436-85e4d4a7255e	0	20	f	\N	\N
aa0ff9c1-6e89-4733-980a-44b5700b52e2	\N	client-secret	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	68eaceab-b2b6-4929-a9d6-200c202d0dfc	2	10	f	\N	\N
33000588-7265-48bf-8d90-cee180f93d7b	\N	client-jwt	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	68eaceab-b2b6-4929-a9d6-200c202d0dfc	2	20	f	\N	\N
d0af103f-6adc-4f19-a612-cd4478399f51	\N	client-secret-jwt	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	68eaceab-b2b6-4929-a9d6-200c202d0dfc	2	30	f	\N	\N
434b2c8e-b2ac-4835-801a-b15b800ceb01	\N	client-x509	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	68eaceab-b2b6-4929-a9d6-200c202d0dfc	2	40	f	\N	\N
3404c88d-55b9-4eaa-b015-eba953aecefb	\N	idp-review-profile	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	f6802893-8e03-47ad-98b1-7f447241c20f	0	10	f	\N	7ef73e35-526a-47e4-bba4-c3376ff1ee2f
4597c43f-adea-41ef-a46f-c5337f3dfe8e	\N	\N	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	f6802893-8e03-47ad-98b1-7f447241c20f	0	20	t	4fd73f2c-e17b-467c-b5b1-4685c5ee7e36	\N
80c655cd-4384-4333-8c58-9a8947898455	\N	idp-create-user-if-unique	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	4fd73f2c-e17b-467c-b5b1-4685c5ee7e36	2	10	f	\N	bce18981-eae8-422b-99a6-84417972bd59
b27085a6-4c1a-46a2-86fb-f8ce1a652a2f	\N	\N	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	4fd73f2c-e17b-467c-b5b1-4685c5ee7e36	2	20	t	b7d0645d-3089-4e04-804d-ba49a750085b	\N
94dfe94f-6fcd-48b3-8f9e-e7fb99f66c6a	\N	idp-confirm-link	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	b7d0645d-3089-4e04-804d-ba49a750085b	0	10	f	\N	\N
d6d0fb1c-e07b-4653-90aa-eb9c44b6e69f	\N	\N	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	b7d0645d-3089-4e04-804d-ba49a750085b	0	20	t	37931898-7d3f-4eae-84a2-02e0d88c4020	\N
cdd6b27e-1eb8-4bce-895e-0d47d7e4732b	\N	idp-email-verification	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	37931898-7d3f-4eae-84a2-02e0d88c4020	2	10	f	\N	\N
904064c3-9d88-4ffa-b605-8c12621c382f	\N	\N	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	37931898-7d3f-4eae-84a2-02e0d88c4020	2	20	t	12b90486-7b84-4bd8-897f-9753df6c274d	\N
43875ae3-ccbc-4b7d-9828-4ba3f181c3fb	\N	idp-username-password-form	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	12b90486-7b84-4bd8-897f-9753df6c274d	0	10	f	\N	\N
6b40eaee-655d-432e-b5fb-d4283fdea9df	\N	\N	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	12b90486-7b84-4bd8-897f-9753df6c274d	1	20	t	71075c2e-f351-4fd3-b29b-f964ec3b3746	\N
2c53dbf2-f13f-4de8-8360-a25db520117a	\N	conditional-user-configured	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	71075c2e-f351-4fd3-b29b-f964ec3b3746	0	10	f	\N	\N
e8d696d3-3948-4093-ba2b-3f190418f28b	\N	auth-otp-form	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	71075c2e-f351-4fd3-b29b-f964ec3b3746	0	20	f	\N	\N
4e9972e5-0583-4789-9b14-2a5ee1992004	\N	http-basic-authenticator	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	6ea0f1af-2643-4f16-a6c8-92717c114483	0	10	f	\N	\N
606ead10-34c5-4b02-83a5-5642a8fbfdd2	\N	docker-http-basic-authenticator	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	2b0fb145-a609-48e8-b56a-d8f52f98c914	0	10	f	\N	\N
c05c9d4a-4a3c-4f78-a097-5385d436848f	\N	no-cookie-redirect	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	f02ddd11-73e0-4ed0-9846-d91c72b86414	0	10	f	\N	\N
0e300b7b-5124-4bf1-bdc1-2647099b3630	\N	\N	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	f02ddd11-73e0-4ed0-9846-d91c72b86414	0	20	t	8e02d1e7-4199-4b24-b013-879d196a3ad6	\N
b13fb2b8-c169-4108-94ac-53f027d72f78	\N	basic-auth	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	8e02d1e7-4199-4b24-b013-879d196a3ad6	0	10	f	\N	\N
6b8fafa1-4533-42cc-8308-50e14863b86b	\N	basic-auth-otp	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	8e02d1e7-4199-4b24-b013-879d196a3ad6	3	20	f	\N	\N
f2a313e5-b35c-496b-a177-2f2e937e5613	\N	auth-spnego	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	8e02d1e7-4199-4b24-b013-879d196a3ad6	3	30	f	\N	\N
0019ad0a-2eb1-474f-bdb4-9318e16975f6	\N	auth-cookie	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	a09e9105-c58e-45f0-b191-8590a43812e1	2	10	f	\N	\N
02bdccda-1e97-4077-b4f5-02bccdabc2e5	\N	auth-spnego	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	a09e9105-c58e-45f0-b191-8590a43812e1	3	20	f	\N	\N
2e433e2b-fec3-4ddc-899b-3bcb7ff8e0ef	\N	identity-provider-redirector	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	a09e9105-c58e-45f0-b191-8590a43812e1	2	25	f	\N	\N
36509b46-c487-49f9-89f4-6753b63e573a	\N	\N	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	a09e9105-c58e-45f0-b191-8590a43812e1	2	30	t	4e9ab636-5713-4c2b-92f5-55afbb8c86a9	\N
754cbf28-ef10-4b80-94a0-6148687e12ef	\N	auth-username-password-form	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	4e9ab636-5713-4c2b-92f5-55afbb8c86a9	0	10	f	\N	\N
f0cb3012-4d86-49d3-a38c-0106eb6b05f6	\N	\N	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	4e9ab636-5713-4c2b-92f5-55afbb8c86a9	1	20	t	6509670d-95df-42e5-9559-bacb5e2ad02e	\N
50f75b3b-b717-4438-9151-e613d2095070	\N	conditional-user-configured	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	6509670d-95df-42e5-9559-bacb5e2ad02e	0	10	f	\N	\N
40555190-3366-4b8b-8992-110aaf2bae7b	\N	auth-otp-form	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	6509670d-95df-42e5-9559-bacb5e2ad02e	0	20	f	\N	\N
53b3adf9-e016-46b1-99ce-90d483177cff	\N	direct-grant-validate-username	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	420314f2-27ba-443c-8021-dee85aaf9757	0	10	f	\N	\N
fc1d25af-b970-45bf-83f7-02eacf170138	\N	direct-grant-validate-password	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	420314f2-27ba-443c-8021-dee85aaf9757	0	20	f	\N	\N
fa3904d7-2bca-4ead-a31a-029ab2788302	\N	\N	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	420314f2-27ba-443c-8021-dee85aaf9757	1	30	t	f83db12b-6861-4837-b1bd-2341bd65ae09	\N
d856555d-8dc4-4e40-b99e-f0b1098615d7	\N	conditional-user-configured	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	f83db12b-6861-4837-b1bd-2341bd65ae09	0	10	f	\N	\N
f3761b1d-f423-40f8-a8cc-011176631248	\N	direct-grant-validate-otp	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	f83db12b-6861-4837-b1bd-2341bd65ae09	0	20	f	\N	\N
6679a408-9a92-4727-b873-8a0939a7a798	\N	registration-page-form	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	69dac60a-d530-459e-97bc-2d00bd8546bf	0	10	t	ef487e8a-d76a-4f84-8572-f333e4fc7ba7	\N
ed9990ef-cb0c-484c-99cd-32f10b7cbe83	\N	registration-user-creation	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	ef487e8a-d76a-4f84-8572-f333e4fc7ba7	0	20	f	\N	\N
45b0a082-c54a-428f-a42c-7282127ff771	\N	registration-profile-action	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	ef487e8a-d76a-4f84-8572-f333e4fc7ba7	0	40	f	\N	\N
39ba3451-aa3f-4c8d-a50f-854c8e0816a8	\N	registration-password-action	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	ef487e8a-d76a-4f84-8572-f333e4fc7ba7	0	50	f	\N	\N
e750b357-a779-4bb5-add4-3e0809cdd7d6	\N	registration-recaptcha-action	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	ef487e8a-d76a-4f84-8572-f333e4fc7ba7	3	60	f	\N	\N
a910edc5-24dd-4189-a154-26777bacf830	\N	reset-credentials-choose-user	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	92c61584-2239-45e1-8bc4-b69740715f0c	0	10	f	\N	\N
f1a8b6c3-e0ee-42f1-8b06-bb80b43b4502	\N	reset-credential-email	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	92c61584-2239-45e1-8bc4-b69740715f0c	0	20	f	\N	\N
5ac0baae-d859-4965-93d4-96a8ab19d4d2	\N	reset-password	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	92c61584-2239-45e1-8bc4-b69740715f0c	0	30	f	\N	\N
2797acdc-1196-4822-9381-6953c7cda3ff	\N	\N	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	92c61584-2239-45e1-8bc4-b69740715f0c	1	40	t	0d4fd201-6679-44f3-8e20-8033a5780e99	\N
1f9f010c-2234-4394-a4d2-0b06126b2bd4	\N	conditional-user-configured	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	0d4fd201-6679-44f3-8e20-8033a5780e99	0	10	f	\N	\N
d4debb4c-451e-47b6-86fd-c278c2c5acff	\N	reset-otp	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	0d4fd201-6679-44f3-8e20-8033a5780e99	0	20	f	\N	\N
78d2457c-f81d-4805-974c-1631ce33b3ea	\N	client-secret	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	033a85b9-98a5-479f-9b85-11276246a238	2	10	f	\N	\N
7394c326-3869-4ca7-93cd-334e784f0873	\N	client-jwt	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	033a85b9-98a5-479f-9b85-11276246a238	2	20	f	\N	\N
1e2a27b7-ec5a-4d5c-9f0c-48345b768053	\N	client-secret-jwt	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	033a85b9-98a5-479f-9b85-11276246a238	2	30	f	\N	\N
25b2b7f0-6b24-48e5-ae53-ff5fc4e11c97	\N	client-x509	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	033a85b9-98a5-479f-9b85-11276246a238	2	40	f	\N	\N
dfd387c1-4f86-4732-9a2e-f1207dc4c07e	\N	idp-review-profile	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	a5488528-ddab-4d8b-a45d-8cf1775aa2b1	0	10	f	\N	0038efbb-d781-4ac0-90b9-a104636de5bd
036cb260-23c6-4599-ac2a-e92841b059c6	\N	\N	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	a5488528-ddab-4d8b-a45d-8cf1775aa2b1	0	20	t	8547884e-6ce6-4796-826e-9a2ab1bf8647	\N
7d72030c-968f-4a48-b46d-a31f815ded18	\N	idp-create-user-if-unique	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	8547884e-6ce6-4796-826e-9a2ab1bf8647	2	10	f	\N	5881d0cd-bcc9-4d75-8326-982c9cbdddc6
c99b13c8-cfd9-4b93-a2bb-9b4d10897d82	\N	\N	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	8547884e-6ce6-4796-826e-9a2ab1bf8647	2	20	t	57b82d98-1de1-4eef-812e-f7affa0e3832	\N
322301f8-2122-4da7-8c03-08660a668543	\N	idp-confirm-link	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	57b82d98-1de1-4eef-812e-f7affa0e3832	0	10	f	\N	\N
8517869a-e286-4c3b-b24e-497bac53f788	\N	\N	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	57b82d98-1de1-4eef-812e-f7affa0e3832	0	20	t	11a5ae77-ced4-4a09-854c-a36bca5a55a9	\N
3a63a42d-e0e6-468e-b3a7-0be260146303	\N	idp-email-verification	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	11a5ae77-ced4-4a09-854c-a36bca5a55a9	2	10	f	\N	\N
5beb3329-f5f9-4c45-a70f-00043cfb883e	\N	\N	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	11a5ae77-ced4-4a09-854c-a36bca5a55a9	2	20	t	b2c37294-0a38-42af-9f2d-c373990bf22a	\N
0c8c7bca-9176-4d63-805b-2077472dc567	\N	idp-username-password-form	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	b2c37294-0a38-42af-9f2d-c373990bf22a	0	10	f	\N	\N
87c799a5-02aa-4fe7-8466-c05900974334	\N	\N	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	b2c37294-0a38-42af-9f2d-c373990bf22a	1	20	t	34658d9b-8304-4ee5-8079-760cf5a2810a	\N
c7fb2156-46f4-4717-a6c6-b7ca845d135c	\N	conditional-user-configured	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	34658d9b-8304-4ee5-8079-760cf5a2810a	0	10	f	\N	\N
625ee1bf-9d2f-4d8d-bcf9-6129991b613a	\N	auth-otp-form	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	34658d9b-8304-4ee5-8079-760cf5a2810a	0	20	f	\N	\N
f97c177d-4164-4bee-b751-0f1cf9b2c0c7	\N	http-basic-authenticator	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	e4362f58-2d3f-4840-824b-9183e440be7e	0	10	f	\N	\N
8ba2bb0f-6f73-4902-bae1-1858adde6fa9	\N	docker-http-basic-authenticator	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	983b5ad1-f8e5-4707-9395-5c9bab75dde1	0	10	f	\N	\N
19757a3b-c063-412c-a069-d8241201c441	\N	no-cookie-redirect	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	46647e66-827f-4c8d-9de4-5c4a9c0f64f9	0	10	f	\N	\N
7ac9f036-891d-480d-b02f-e79412dbd987	\N	\N	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	46647e66-827f-4c8d-9de4-5c4a9c0f64f9	0	20	t	b95a3a54-01ee-4e8f-bfae-3d4a357cce22	\N
5556a831-c9b8-442d-acb8-2145ae67c884	\N	basic-auth	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	b95a3a54-01ee-4e8f-bfae-3d4a357cce22	0	10	f	\N	\N
c3639421-f4b2-469d-8e50-8d1b635bef81	\N	basic-auth-otp	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	b95a3a54-01ee-4e8f-bfae-3d4a357cce22	3	20	f	\N	\N
fece6362-5bc4-4569-a21e-421f86c1b888	\N	auth-spnego	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	b95a3a54-01ee-4e8f-bfae-3d4a357cce22	3	30	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
cc1793bb-b836-4e16-b06b-ea1840b0b2e2	browser	browser based authentication	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	basic-flow	t	t
99187b7f-e063-4fc2-85c8-41cc94a8bf8f	forms	Username, password, otp and other auth forms.	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	basic-flow	f	t
9e834f36-885e-4ca8-b5a3-c35b8532f092	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	basic-flow	f	t
256ebaa4-f0e3-4027-af03-6e8a9a1cc6fd	direct grant	OpenID Connect Resource Owner Grant	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	basic-flow	t	t
b78ba4ee-578b-4444-b941-d2da62ad1ada	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	basic-flow	f	t
16836c02-fc4c-4f47-90eb-14e0a73884f1	registration	registration flow	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	basic-flow	t	t
d7d7550b-5981-4cda-8a81-444a09e74a59	registration form	registration form	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	form-flow	f	t
fea957fa-5886-45af-aaf5-22f124e3e865	reset credentials	Reset credentials for a user if they forgot their password or something	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	basic-flow	t	t
4c52297d-b277-4eee-b436-85e4d4a7255e	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	basic-flow	f	t
68eaceab-b2b6-4929-a9d6-200c202d0dfc	clients	Base authentication for clients	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	client-flow	t	t
f6802893-8e03-47ad-98b1-7f447241c20f	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	basic-flow	t	t
4fd73f2c-e17b-467c-b5b1-4685c5ee7e36	User creation or linking	Flow for the existing/non-existing user alternatives	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	basic-flow	f	t
b7d0645d-3089-4e04-804d-ba49a750085b	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	basic-flow	f	t
37931898-7d3f-4eae-84a2-02e0d88c4020	Account verification options	Method with which to verity the existing account	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	basic-flow	f	t
12b90486-7b84-4bd8-897f-9753df6c274d	Verify Existing Account by Re-authentication	Reauthentication of existing account	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	basic-flow	f	t
71075c2e-f351-4fd3-b29b-f964ec3b3746	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	basic-flow	f	t
6ea0f1af-2643-4f16-a6c8-92717c114483	saml ecp	SAML ECP Profile Authentication Flow	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	basic-flow	t	t
2b0fb145-a609-48e8-b56a-d8f52f98c914	docker auth	Used by Docker clients to authenticate against the IDP	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	basic-flow	t	t
f02ddd11-73e0-4ed0-9846-d91c72b86414	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	basic-flow	t	t
8e02d1e7-4199-4b24-b013-879d196a3ad6	Authentication Options	Authentication options.	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	basic-flow	f	t
a09e9105-c58e-45f0-b191-8590a43812e1	browser	browser based authentication	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	basic-flow	t	t
4e9ab636-5713-4c2b-92f5-55afbb8c86a9	forms	Username, password, otp and other auth forms.	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	basic-flow	f	t
6509670d-95df-42e5-9559-bacb5e2ad02e	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	basic-flow	f	t
420314f2-27ba-443c-8021-dee85aaf9757	direct grant	OpenID Connect Resource Owner Grant	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	basic-flow	t	t
f83db12b-6861-4837-b1bd-2341bd65ae09	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	basic-flow	f	t
69dac60a-d530-459e-97bc-2d00bd8546bf	registration	registration flow	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	basic-flow	t	t
ef487e8a-d76a-4f84-8572-f333e4fc7ba7	registration form	registration form	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	form-flow	f	t
92c61584-2239-45e1-8bc4-b69740715f0c	reset credentials	Reset credentials for a user if they forgot their password or something	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	basic-flow	t	t
0d4fd201-6679-44f3-8e20-8033a5780e99	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	basic-flow	f	t
033a85b9-98a5-479f-9b85-11276246a238	clients	Base authentication for clients	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	client-flow	t	t
a5488528-ddab-4d8b-a45d-8cf1775aa2b1	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	basic-flow	t	t
8547884e-6ce6-4796-826e-9a2ab1bf8647	User creation or linking	Flow for the existing/non-existing user alternatives	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	basic-flow	f	t
57b82d98-1de1-4eef-812e-f7affa0e3832	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	basic-flow	f	t
11a5ae77-ced4-4a09-854c-a36bca5a55a9	Account verification options	Method with which to verity the existing account	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	basic-flow	f	t
b2c37294-0a38-42af-9f2d-c373990bf22a	Verify Existing Account by Re-authentication	Reauthentication of existing account	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	basic-flow	f	t
34658d9b-8304-4ee5-8079-760cf5a2810a	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	basic-flow	f	t
e4362f58-2d3f-4840-824b-9183e440be7e	saml ecp	SAML ECP Profile Authentication Flow	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	basic-flow	t	t
983b5ad1-f8e5-4707-9395-5c9bab75dde1	docker auth	Used by Docker clients to authenticate against the IDP	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	basic-flow	t	t
46647e66-827f-4c8d-9de4-5c4a9c0f64f9	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	basic-flow	t	t
b95a3a54-01ee-4e8f-bfae-3d4a357cce22	Authentication Options	Authentication options.	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	basic-flow	f	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
7ef73e35-526a-47e4-bba4-c3376ff1ee2f	review profile config	e47c4261-2e1f-40a1-a6b0-9430a59b71fd
bce18981-eae8-422b-99a6-84417972bd59	create unique user config	e47c4261-2e1f-40a1-a6b0-9430a59b71fd
0038efbb-d781-4ac0-90b9-a104636de5bd	review profile config	912f0e36-c9a1-43b2-8a41-f3ef56854ae3
5881d0cd-bcc9-4d75-8326-982c9cbdddc6	create unique user config	912f0e36-c9a1-43b2-8a41-f3ef56854ae3
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
7ef73e35-526a-47e4-bba4-c3376ff1ee2f	missing	update.profile.on.first.login
bce18981-eae8-422b-99a6-84417972bd59	false	require.password.update.after.registration
0038efbb-d781-4ac0-90b9-a104636de5bd	missing	update.profile.on.first.login
5881d0cd-bcc9-4d75-8326-982c9cbdddc6	false	require.password.update.after.registration
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
87cb64f7-838a-423f-bc1b-1fe934f609a8	t	f	master-realm	0	f	\N	\N	t	\N	f	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
a4b9d5b4-4506-46bd-9fae-97d61da1b553	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
67e37d4b-6f6f-43ff-b761-e3692dca9c05	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
2fc17c2c-939d-4b4c-b1fa-fdfab1033b5d	t	f	broker	0	f	\N	\N	t	\N	f	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
ddd67d36-1bb3-4ad3-bb85-07934e174e09	t	f	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
e1730680-f4a7-45e0-bcbb-7459281966da	t	f	admin-cli	0	t	\N	\N	f	\N	f	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
66862fec-33ea-4c4d-a38e-0946f3b33ebb	t	f	broker	0	f	\N	\N	t	\N	f	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
854ef916-6fc8-4da4-a6ca-a1a0ac16cd66	t	f	security-admin-console	0	t	\N	/admin/main/console/	f	\N	f	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
459fee19-7be3-4b66-b2cc-7d966e0ed405	t	f	admin-cli	0	t	\N	\N	f	\N	f	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
fbd356ac-40ee-470f-a677-7158e3c3c401	t	f	account-console	0	t	\N	/realms/main/account/	f	\N	f	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
e250b166-3cba-4c76-994e-fb54ee85771b	t	f	main-realm	0	f	\N	\N	t	\N	f	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	\N	0	f	f	main Realm	f	client-secret	\N	\N	\N	t	f	f	f
11360bd3-a08f-4223-87a1-fa1990a6f7cf	t	f	realm-management	0	f	\N	\N	t	\N	f	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
d15f4ea4-a056-439d-8eac-ea5743e8693a	t	f	account	0	t	\N	/realms/main/account/	f	\N	f	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
84ebb1c4-7bf6-4b95-a8d9-b7980f700484	t	t	argocd	0	f	GQjfMEUBLqyXBW6kxMhYQLdv0AdZh0PI		f	http://argocd.kube.local	f	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	openid-connect	-1	t	f		f	client-secret	http://argocd.kube.local		\N	t	f	t	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_attributes (client_id, value, name) FROM stdin;
a4b9d5b4-4506-46bd-9fae-97d61da1b553	+	post.logout.redirect.uris
67e37d4b-6f6f-43ff-b761-e3692dca9c05	+	post.logout.redirect.uris
67e37d4b-6f6f-43ff-b761-e3692dca9c05	S256	pkce.code.challenge.method
ddd67d36-1bb3-4ad3-bb85-07934e174e09	+	post.logout.redirect.uris
ddd67d36-1bb3-4ad3-bb85-07934e174e09	S256	pkce.code.challenge.method
d15f4ea4-a056-439d-8eac-ea5743e8693a	+	post.logout.redirect.uris
854ef916-6fc8-4da4-a6ca-a1a0ac16cd66	+	post.logout.redirect.uris
854ef916-6fc8-4da4-a6ca-a1a0ac16cd66	S256	pkce.code.challenge.method
fbd356ac-40ee-470f-a677-7158e3c3c401	+	post.logout.redirect.uris
fbd356ac-40ee-470f-a677-7158e3c3c401	S256	pkce.code.challenge.method
84ebb1c4-7bf6-4b95-a8d9-b7980f700484	false	oidc.ciba.grant.enabled
84ebb1c4-7bf6-4b95-a8d9-b7980f700484	1664564218	client.secret.creation.time
84ebb1c4-7bf6-4b95-a8d9-b7980f700484	true	backchannel.logout.session.required
84ebb1c4-7bf6-4b95-a8d9-b7980f700484	false	display.on.consent.screen
84ebb1c4-7bf6-4b95-a8d9-b7980f700484	false	oauth2.device.authorization.grant.enabled
84ebb1c4-7bf6-4b95-a8d9-b7980f700484	false	backchannel.logout.revoke.offline.tokens
84ebb1c4-7bf6-4b95-a8d9-b7980f700484	+	post.logout.redirect.uris
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
fe921baa-ae75-4eb0-a28d-56c59da396d1	offline_access	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	OpenID Connect built-in scope: offline_access	openid-connect
478c8808-66a7-47f5-895a-67d1f9313a0a	role_list	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	SAML role list	saml
70bca347-d54f-4779-a6dd-de0b91110f94	profile	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	OpenID Connect built-in scope: profile	openid-connect
bf4bc2c0-263f-4105-8d69-da53aa5fb727	email	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	OpenID Connect built-in scope: email	openid-connect
1abbe72f-3c2c-4d62-b805-79e2e6983892	address	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	OpenID Connect built-in scope: address	openid-connect
062021a8-0ef2-436b-9c27-a85e387ca38f	phone	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	OpenID Connect built-in scope: phone	openid-connect
12649fa6-b956-4cc7-8a96-4623232d9645	roles	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	OpenID Connect scope for add user roles to the access token	openid-connect
16afb0cc-9cf7-469b-8b13-170333db0c09	web-origins	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	OpenID Connect scope for add allowed web origins to the access token	openid-connect
c6d3c6c8-a27b-4f2b-91fc-2dc1e3782a04	microprofile-jwt	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	Microprofile - JWT built-in scope	openid-connect
5b98c033-d03b-49ea-a3c4-7bcb3906ea65	acr	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
1ffdf604-977d-4c34-9dc5-75d3002287c7	web-origins	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	OpenID Connect scope for add allowed web origins to the access token	openid-connect
9f4718d1-8087-41af-807d-7a6a838915f7	microprofile-jwt	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	Microprofile - JWT built-in scope	openid-connect
b43e334f-9de4-4441-b905-429eddeb186b	acr	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
48f799ab-ab44-4058-8cea-73373b2e8a32	offline_access	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	OpenID Connect built-in scope: offline_access	openid-connect
a0980e08-4063-4f4b-961d-a6238809f7d6	role_list	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	SAML role list	saml
45fdb136-c454-41d6-98ad-5bcfe946bebe	profile	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	OpenID Connect built-in scope: profile	openid-connect
8985de0b-9b3a-4841-a4b1-9fe2accf619e	email	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	OpenID Connect built-in scope: email	openid-connect
9d537f5f-a2ac-4b28-a81f-51ce1af56815	address	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	OpenID Connect built-in scope: address	openid-connect
f479f754-80e5-4054-a0cd-7406fe1b1c85	phone	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	OpenID Connect built-in scope: phone	openid-connect
634fb130-fe94-4da8-91cd-42c07e684502	roles	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	OpenID Connect scope for add user roles to the access token	openid-connect
5c314bab-7d84-446e-a073-bbc976f3b4b9	argocd_clients	912f0e36-c9a1-43b2-8a41-f3ef56854ae3		openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
fe921baa-ae75-4eb0-a28d-56c59da396d1	true	display.on.consent.screen
fe921baa-ae75-4eb0-a28d-56c59da396d1	${offlineAccessScopeConsentText}	consent.screen.text
478c8808-66a7-47f5-895a-67d1f9313a0a	true	display.on.consent.screen
478c8808-66a7-47f5-895a-67d1f9313a0a	${samlRoleListScopeConsentText}	consent.screen.text
70bca347-d54f-4779-a6dd-de0b91110f94	true	display.on.consent.screen
70bca347-d54f-4779-a6dd-de0b91110f94	${profileScopeConsentText}	consent.screen.text
70bca347-d54f-4779-a6dd-de0b91110f94	true	include.in.token.scope
bf4bc2c0-263f-4105-8d69-da53aa5fb727	true	display.on.consent.screen
bf4bc2c0-263f-4105-8d69-da53aa5fb727	${emailScopeConsentText}	consent.screen.text
bf4bc2c0-263f-4105-8d69-da53aa5fb727	true	include.in.token.scope
1abbe72f-3c2c-4d62-b805-79e2e6983892	true	display.on.consent.screen
1abbe72f-3c2c-4d62-b805-79e2e6983892	${addressScopeConsentText}	consent.screen.text
1abbe72f-3c2c-4d62-b805-79e2e6983892	true	include.in.token.scope
062021a8-0ef2-436b-9c27-a85e387ca38f	true	display.on.consent.screen
062021a8-0ef2-436b-9c27-a85e387ca38f	${phoneScopeConsentText}	consent.screen.text
062021a8-0ef2-436b-9c27-a85e387ca38f	true	include.in.token.scope
12649fa6-b956-4cc7-8a96-4623232d9645	true	display.on.consent.screen
12649fa6-b956-4cc7-8a96-4623232d9645	${rolesScopeConsentText}	consent.screen.text
12649fa6-b956-4cc7-8a96-4623232d9645	false	include.in.token.scope
16afb0cc-9cf7-469b-8b13-170333db0c09	false	display.on.consent.screen
16afb0cc-9cf7-469b-8b13-170333db0c09		consent.screen.text
16afb0cc-9cf7-469b-8b13-170333db0c09	false	include.in.token.scope
c6d3c6c8-a27b-4f2b-91fc-2dc1e3782a04	false	display.on.consent.screen
c6d3c6c8-a27b-4f2b-91fc-2dc1e3782a04	true	include.in.token.scope
5b98c033-d03b-49ea-a3c4-7bcb3906ea65	false	display.on.consent.screen
5b98c033-d03b-49ea-a3c4-7bcb3906ea65	false	include.in.token.scope
48f799ab-ab44-4058-8cea-73373b2e8a32	true	display.on.consent.screen
48f799ab-ab44-4058-8cea-73373b2e8a32	${offlineAccessScopeConsentText}	consent.screen.text
a0980e08-4063-4f4b-961d-a6238809f7d6	true	display.on.consent.screen
a0980e08-4063-4f4b-961d-a6238809f7d6	${samlRoleListScopeConsentText}	consent.screen.text
45fdb136-c454-41d6-98ad-5bcfe946bebe	true	display.on.consent.screen
45fdb136-c454-41d6-98ad-5bcfe946bebe	${profileScopeConsentText}	consent.screen.text
45fdb136-c454-41d6-98ad-5bcfe946bebe	true	include.in.token.scope
8985de0b-9b3a-4841-a4b1-9fe2accf619e	true	display.on.consent.screen
8985de0b-9b3a-4841-a4b1-9fe2accf619e	${emailScopeConsentText}	consent.screen.text
8985de0b-9b3a-4841-a4b1-9fe2accf619e	true	include.in.token.scope
9d537f5f-a2ac-4b28-a81f-51ce1af56815	true	display.on.consent.screen
9d537f5f-a2ac-4b28-a81f-51ce1af56815	${addressScopeConsentText}	consent.screen.text
9d537f5f-a2ac-4b28-a81f-51ce1af56815	true	include.in.token.scope
f479f754-80e5-4054-a0cd-7406fe1b1c85	true	display.on.consent.screen
f479f754-80e5-4054-a0cd-7406fe1b1c85	${phoneScopeConsentText}	consent.screen.text
f479f754-80e5-4054-a0cd-7406fe1b1c85	true	include.in.token.scope
634fb130-fe94-4da8-91cd-42c07e684502	true	display.on.consent.screen
634fb130-fe94-4da8-91cd-42c07e684502	${rolesScopeConsentText}	consent.screen.text
634fb130-fe94-4da8-91cd-42c07e684502	false	include.in.token.scope
1ffdf604-977d-4c34-9dc5-75d3002287c7	false	display.on.consent.screen
1ffdf604-977d-4c34-9dc5-75d3002287c7		consent.screen.text
1ffdf604-977d-4c34-9dc5-75d3002287c7	false	include.in.token.scope
9f4718d1-8087-41af-807d-7a6a838915f7	false	display.on.consent.screen
9f4718d1-8087-41af-807d-7a6a838915f7	true	include.in.token.scope
b43e334f-9de4-4441-b905-429eddeb186b	false	display.on.consent.screen
b43e334f-9de4-4441-b905-429eddeb186b	false	include.in.token.scope
5c314bab-7d84-446e-a073-bbc976f3b4b9		consent.screen.text
5c314bab-7d84-446e-a073-bbc976f3b4b9	true	display.on.consent.screen
5c314bab-7d84-446e-a073-bbc976f3b4b9	true	include.in.token.scope
5c314bab-7d84-446e-a073-bbc976f3b4b9		gui.order
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
a4b9d5b4-4506-46bd-9fae-97d61da1b553	5b98c033-d03b-49ea-a3c4-7bcb3906ea65	t
a4b9d5b4-4506-46bd-9fae-97d61da1b553	bf4bc2c0-263f-4105-8d69-da53aa5fb727	t
a4b9d5b4-4506-46bd-9fae-97d61da1b553	16afb0cc-9cf7-469b-8b13-170333db0c09	t
a4b9d5b4-4506-46bd-9fae-97d61da1b553	12649fa6-b956-4cc7-8a96-4623232d9645	t
a4b9d5b4-4506-46bd-9fae-97d61da1b553	70bca347-d54f-4779-a6dd-de0b91110f94	t
a4b9d5b4-4506-46bd-9fae-97d61da1b553	c6d3c6c8-a27b-4f2b-91fc-2dc1e3782a04	f
a4b9d5b4-4506-46bd-9fae-97d61da1b553	1abbe72f-3c2c-4d62-b805-79e2e6983892	f
a4b9d5b4-4506-46bd-9fae-97d61da1b553	062021a8-0ef2-436b-9c27-a85e387ca38f	f
a4b9d5b4-4506-46bd-9fae-97d61da1b553	fe921baa-ae75-4eb0-a28d-56c59da396d1	f
67e37d4b-6f6f-43ff-b761-e3692dca9c05	5b98c033-d03b-49ea-a3c4-7bcb3906ea65	t
67e37d4b-6f6f-43ff-b761-e3692dca9c05	bf4bc2c0-263f-4105-8d69-da53aa5fb727	t
67e37d4b-6f6f-43ff-b761-e3692dca9c05	16afb0cc-9cf7-469b-8b13-170333db0c09	t
67e37d4b-6f6f-43ff-b761-e3692dca9c05	12649fa6-b956-4cc7-8a96-4623232d9645	t
67e37d4b-6f6f-43ff-b761-e3692dca9c05	70bca347-d54f-4779-a6dd-de0b91110f94	t
67e37d4b-6f6f-43ff-b761-e3692dca9c05	c6d3c6c8-a27b-4f2b-91fc-2dc1e3782a04	f
67e37d4b-6f6f-43ff-b761-e3692dca9c05	1abbe72f-3c2c-4d62-b805-79e2e6983892	f
67e37d4b-6f6f-43ff-b761-e3692dca9c05	062021a8-0ef2-436b-9c27-a85e387ca38f	f
67e37d4b-6f6f-43ff-b761-e3692dca9c05	fe921baa-ae75-4eb0-a28d-56c59da396d1	f
e1730680-f4a7-45e0-bcbb-7459281966da	5b98c033-d03b-49ea-a3c4-7bcb3906ea65	t
e1730680-f4a7-45e0-bcbb-7459281966da	bf4bc2c0-263f-4105-8d69-da53aa5fb727	t
e1730680-f4a7-45e0-bcbb-7459281966da	16afb0cc-9cf7-469b-8b13-170333db0c09	t
e1730680-f4a7-45e0-bcbb-7459281966da	12649fa6-b956-4cc7-8a96-4623232d9645	t
e1730680-f4a7-45e0-bcbb-7459281966da	70bca347-d54f-4779-a6dd-de0b91110f94	t
e1730680-f4a7-45e0-bcbb-7459281966da	c6d3c6c8-a27b-4f2b-91fc-2dc1e3782a04	f
e1730680-f4a7-45e0-bcbb-7459281966da	1abbe72f-3c2c-4d62-b805-79e2e6983892	f
e1730680-f4a7-45e0-bcbb-7459281966da	062021a8-0ef2-436b-9c27-a85e387ca38f	f
e1730680-f4a7-45e0-bcbb-7459281966da	fe921baa-ae75-4eb0-a28d-56c59da396d1	f
2fc17c2c-939d-4b4c-b1fa-fdfab1033b5d	5b98c033-d03b-49ea-a3c4-7bcb3906ea65	t
2fc17c2c-939d-4b4c-b1fa-fdfab1033b5d	bf4bc2c0-263f-4105-8d69-da53aa5fb727	t
2fc17c2c-939d-4b4c-b1fa-fdfab1033b5d	16afb0cc-9cf7-469b-8b13-170333db0c09	t
2fc17c2c-939d-4b4c-b1fa-fdfab1033b5d	12649fa6-b956-4cc7-8a96-4623232d9645	t
2fc17c2c-939d-4b4c-b1fa-fdfab1033b5d	70bca347-d54f-4779-a6dd-de0b91110f94	t
2fc17c2c-939d-4b4c-b1fa-fdfab1033b5d	c6d3c6c8-a27b-4f2b-91fc-2dc1e3782a04	f
2fc17c2c-939d-4b4c-b1fa-fdfab1033b5d	1abbe72f-3c2c-4d62-b805-79e2e6983892	f
2fc17c2c-939d-4b4c-b1fa-fdfab1033b5d	062021a8-0ef2-436b-9c27-a85e387ca38f	f
2fc17c2c-939d-4b4c-b1fa-fdfab1033b5d	fe921baa-ae75-4eb0-a28d-56c59da396d1	f
87cb64f7-838a-423f-bc1b-1fe934f609a8	5b98c033-d03b-49ea-a3c4-7bcb3906ea65	t
87cb64f7-838a-423f-bc1b-1fe934f609a8	bf4bc2c0-263f-4105-8d69-da53aa5fb727	t
87cb64f7-838a-423f-bc1b-1fe934f609a8	16afb0cc-9cf7-469b-8b13-170333db0c09	t
87cb64f7-838a-423f-bc1b-1fe934f609a8	12649fa6-b956-4cc7-8a96-4623232d9645	t
87cb64f7-838a-423f-bc1b-1fe934f609a8	70bca347-d54f-4779-a6dd-de0b91110f94	t
87cb64f7-838a-423f-bc1b-1fe934f609a8	c6d3c6c8-a27b-4f2b-91fc-2dc1e3782a04	f
87cb64f7-838a-423f-bc1b-1fe934f609a8	1abbe72f-3c2c-4d62-b805-79e2e6983892	f
87cb64f7-838a-423f-bc1b-1fe934f609a8	062021a8-0ef2-436b-9c27-a85e387ca38f	f
87cb64f7-838a-423f-bc1b-1fe934f609a8	fe921baa-ae75-4eb0-a28d-56c59da396d1	f
ddd67d36-1bb3-4ad3-bb85-07934e174e09	5b98c033-d03b-49ea-a3c4-7bcb3906ea65	t
ddd67d36-1bb3-4ad3-bb85-07934e174e09	bf4bc2c0-263f-4105-8d69-da53aa5fb727	t
ddd67d36-1bb3-4ad3-bb85-07934e174e09	16afb0cc-9cf7-469b-8b13-170333db0c09	t
ddd67d36-1bb3-4ad3-bb85-07934e174e09	12649fa6-b956-4cc7-8a96-4623232d9645	t
ddd67d36-1bb3-4ad3-bb85-07934e174e09	70bca347-d54f-4779-a6dd-de0b91110f94	t
ddd67d36-1bb3-4ad3-bb85-07934e174e09	c6d3c6c8-a27b-4f2b-91fc-2dc1e3782a04	f
ddd67d36-1bb3-4ad3-bb85-07934e174e09	1abbe72f-3c2c-4d62-b805-79e2e6983892	f
ddd67d36-1bb3-4ad3-bb85-07934e174e09	062021a8-0ef2-436b-9c27-a85e387ca38f	f
ddd67d36-1bb3-4ad3-bb85-07934e174e09	fe921baa-ae75-4eb0-a28d-56c59da396d1	f
fbd356ac-40ee-470f-a677-7158e3c3c401	1ffdf604-977d-4c34-9dc5-75d3002287c7	t
fbd356ac-40ee-470f-a677-7158e3c3c401	b43e334f-9de4-4441-b905-429eddeb186b	t
fbd356ac-40ee-470f-a677-7158e3c3c401	634fb130-fe94-4da8-91cd-42c07e684502	t
fbd356ac-40ee-470f-a677-7158e3c3c401	45fdb136-c454-41d6-98ad-5bcfe946bebe	t
fbd356ac-40ee-470f-a677-7158e3c3c401	8985de0b-9b3a-4841-a4b1-9fe2accf619e	t
fbd356ac-40ee-470f-a677-7158e3c3c401	9d537f5f-a2ac-4b28-a81f-51ce1af56815	f
fbd356ac-40ee-470f-a677-7158e3c3c401	f479f754-80e5-4054-a0cd-7406fe1b1c85	f
fbd356ac-40ee-470f-a677-7158e3c3c401	48f799ab-ab44-4058-8cea-73373b2e8a32	f
fbd356ac-40ee-470f-a677-7158e3c3c401	9f4718d1-8087-41af-807d-7a6a838915f7	f
d15f4ea4-a056-439d-8eac-ea5743e8693a	b43e334f-9de4-4441-b905-429eddeb186b	t
d15f4ea4-a056-439d-8eac-ea5743e8693a	634fb130-fe94-4da8-91cd-42c07e684502	t
d15f4ea4-a056-439d-8eac-ea5743e8693a	8985de0b-9b3a-4841-a4b1-9fe2accf619e	t
d15f4ea4-a056-439d-8eac-ea5743e8693a	1ffdf604-977d-4c34-9dc5-75d3002287c7	t
d15f4ea4-a056-439d-8eac-ea5743e8693a	45fdb136-c454-41d6-98ad-5bcfe946bebe	t
d15f4ea4-a056-439d-8eac-ea5743e8693a	f479f754-80e5-4054-a0cd-7406fe1b1c85	f
d15f4ea4-a056-439d-8eac-ea5743e8693a	9d537f5f-a2ac-4b28-a81f-51ce1af56815	f
d15f4ea4-a056-439d-8eac-ea5743e8693a	48f799ab-ab44-4058-8cea-73373b2e8a32	f
d15f4ea4-a056-439d-8eac-ea5743e8693a	9f4718d1-8087-41af-807d-7a6a838915f7	f
459fee19-7be3-4b66-b2cc-7d966e0ed405	b43e334f-9de4-4441-b905-429eddeb186b	t
459fee19-7be3-4b66-b2cc-7d966e0ed405	634fb130-fe94-4da8-91cd-42c07e684502	t
459fee19-7be3-4b66-b2cc-7d966e0ed405	8985de0b-9b3a-4841-a4b1-9fe2accf619e	t
459fee19-7be3-4b66-b2cc-7d966e0ed405	1ffdf604-977d-4c34-9dc5-75d3002287c7	t
459fee19-7be3-4b66-b2cc-7d966e0ed405	45fdb136-c454-41d6-98ad-5bcfe946bebe	t
459fee19-7be3-4b66-b2cc-7d966e0ed405	f479f754-80e5-4054-a0cd-7406fe1b1c85	f
459fee19-7be3-4b66-b2cc-7d966e0ed405	9d537f5f-a2ac-4b28-a81f-51ce1af56815	f
459fee19-7be3-4b66-b2cc-7d966e0ed405	48f799ab-ab44-4058-8cea-73373b2e8a32	f
459fee19-7be3-4b66-b2cc-7d966e0ed405	9f4718d1-8087-41af-807d-7a6a838915f7	f
66862fec-33ea-4c4d-a38e-0946f3b33ebb	b43e334f-9de4-4441-b905-429eddeb186b	t
66862fec-33ea-4c4d-a38e-0946f3b33ebb	634fb130-fe94-4da8-91cd-42c07e684502	t
66862fec-33ea-4c4d-a38e-0946f3b33ebb	8985de0b-9b3a-4841-a4b1-9fe2accf619e	t
66862fec-33ea-4c4d-a38e-0946f3b33ebb	1ffdf604-977d-4c34-9dc5-75d3002287c7	t
66862fec-33ea-4c4d-a38e-0946f3b33ebb	45fdb136-c454-41d6-98ad-5bcfe946bebe	t
66862fec-33ea-4c4d-a38e-0946f3b33ebb	f479f754-80e5-4054-a0cd-7406fe1b1c85	f
66862fec-33ea-4c4d-a38e-0946f3b33ebb	9d537f5f-a2ac-4b28-a81f-51ce1af56815	f
66862fec-33ea-4c4d-a38e-0946f3b33ebb	48f799ab-ab44-4058-8cea-73373b2e8a32	f
66862fec-33ea-4c4d-a38e-0946f3b33ebb	9f4718d1-8087-41af-807d-7a6a838915f7	f
11360bd3-a08f-4223-87a1-fa1990a6f7cf	b43e334f-9de4-4441-b905-429eddeb186b	t
11360bd3-a08f-4223-87a1-fa1990a6f7cf	634fb130-fe94-4da8-91cd-42c07e684502	t
11360bd3-a08f-4223-87a1-fa1990a6f7cf	8985de0b-9b3a-4841-a4b1-9fe2accf619e	t
11360bd3-a08f-4223-87a1-fa1990a6f7cf	1ffdf604-977d-4c34-9dc5-75d3002287c7	t
11360bd3-a08f-4223-87a1-fa1990a6f7cf	45fdb136-c454-41d6-98ad-5bcfe946bebe	t
11360bd3-a08f-4223-87a1-fa1990a6f7cf	f479f754-80e5-4054-a0cd-7406fe1b1c85	f
11360bd3-a08f-4223-87a1-fa1990a6f7cf	9d537f5f-a2ac-4b28-a81f-51ce1af56815	f
11360bd3-a08f-4223-87a1-fa1990a6f7cf	48f799ab-ab44-4058-8cea-73373b2e8a32	f
11360bd3-a08f-4223-87a1-fa1990a6f7cf	9f4718d1-8087-41af-807d-7a6a838915f7	f
854ef916-6fc8-4da4-a6ca-a1a0ac16cd66	b43e334f-9de4-4441-b905-429eddeb186b	t
854ef916-6fc8-4da4-a6ca-a1a0ac16cd66	634fb130-fe94-4da8-91cd-42c07e684502	t
854ef916-6fc8-4da4-a6ca-a1a0ac16cd66	8985de0b-9b3a-4841-a4b1-9fe2accf619e	t
854ef916-6fc8-4da4-a6ca-a1a0ac16cd66	1ffdf604-977d-4c34-9dc5-75d3002287c7	t
854ef916-6fc8-4da4-a6ca-a1a0ac16cd66	45fdb136-c454-41d6-98ad-5bcfe946bebe	t
854ef916-6fc8-4da4-a6ca-a1a0ac16cd66	f479f754-80e5-4054-a0cd-7406fe1b1c85	f
854ef916-6fc8-4da4-a6ca-a1a0ac16cd66	9d537f5f-a2ac-4b28-a81f-51ce1af56815	f
854ef916-6fc8-4da4-a6ca-a1a0ac16cd66	48f799ab-ab44-4058-8cea-73373b2e8a32	f
854ef916-6fc8-4da4-a6ca-a1a0ac16cd66	9f4718d1-8087-41af-807d-7a6a838915f7	f
84ebb1c4-7bf6-4b95-a8d9-b7980f700484	1ffdf604-977d-4c34-9dc5-75d3002287c7	t
84ebb1c4-7bf6-4b95-a8d9-b7980f700484	b43e334f-9de4-4441-b905-429eddeb186b	t
84ebb1c4-7bf6-4b95-a8d9-b7980f700484	634fb130-fe94-4da8-91cd-42c07e684502	t
84ebb1c4-7bf6-4b95-a8d9-b7980f700484	45fdb136-c454-41d6-98ad-5bcfe946bebe	t
84ebb1c4-7bf6-4b95-a8d9-b7980f700484	8985de0b-9b3a-4841-a4b1-9fe2accf619e	t
84ebb1c4-7bf6-4b95-a8d9-b7980f700484	9d537f5f-a2ac-4b28-a81f-51ce1af56815	f
84ebb1c4-7bf6-4b95-a8d9-b7980f700484	f479f754-80e5-4054-a0cd-7406fe1b1c85	f
84ebb1c4-7bf6-4b95-a8d9-b7980f700484	48f799ab-ab44-4058-8cea-73373b2e8a32	f
84ebb1c4-7bf6-4b95-a8d9-b7980f700484	9f4718d1-8087-41af-807d-7a6a838915f7	f
84ebb1c4-7bf6-4b95-a8d9-b7980f700484	5c314bab-7d84-446e-a073-bbc976f3b4b9	t
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
fe921baa-ae75-4eb0-a28d-56c59da396d1	c46487e1-9957-4665-8130-18e4b258d37e
48f799ab-ab44-4058-8cea-73373b2e8a32	de0b898b-defc-494b-9178-b2b2864a9646
\.


--
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
c1b1390a-c25f-4f0d-b559-ed7bcd32c609	Trusted Hosts	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	anonymous
f01aea1a-07c6-4417-bee0-f6a6e5f8b80c	Consent Required	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	anonymous
51e99b8e-947c-446c-a777-ea45cc2dd269	Full Scope Disabled	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	anonymous
56bbbba0-843e-452f-98ae-f37ecb9c2b93	Max Clients Limit	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	anonymous
a0b805ce-0390-4922-8da1-ac774b2e0f13	Allowed Protocol Mapper Types	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	anonymous
3dd31734-7126-43b9-837e-4d81d02e7259	Allowed Client Scopes	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	anonymous
50ad3834-b2df-4d56-a6c3-c013cecc5d62	Allowed Protocol Mapper Types	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	authenticated
fe694f9c-7894-41a9-88eb-13c634564f6b	Allowed Client Scopes	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	authenticated
43e9e0f2-afaa-4e12-b704-8e06e5f7ee20	rsa-generated	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	rsa-generated	org.keycloak.keys.KeyProvider	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	\N
be137259-8fb0-4a56-99e1-3c494282d598	rsa-enc-generated	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	rsa-enc-generated	org.keycloak.keys.KeyProvider	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	\N
72139084-80d8-404f-835b-02836ac4b6ae	hmac-generated	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	hmac-generated	org.keycloak.keys.KeyProvider	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	\N
c3a7d23d-9c78-4a14-bf3f-6ac9960e716d	aes-generated	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	aes-generated	org.keycloak.keys.KeyProvider	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	\N
b69de475-3b1d-4bc6-8b05-8a6919e50abc	rsa-generated	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	rsa-generated	org.keycloak.keys.KeyProvider	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	\N
3902e4ee-a121-4eac-b773-044c06a2b820	rsa-enc-generated	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	rsa-enc-generated	org.keycloak.keys.KeyProvider	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	\N
52e4bb53-e328-4869-b4d5-0f4ba268b5b0	hmac-generated	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	hmac-generated	org.keycloak.keys.KeyProvider	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	\N
6fbe1728-6b6c-4d87-9c61-f660eac5c7e8	aes-generated	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	aes-generated	org.keycloak.keys.KeyProvider	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	\N
dda0d922-aedc-4378-9ec2-5fe1962acbdf	Trusted Hosts	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	anonymous
ead1f71b-3d86-4e8e-a3c7-edcc666bcd58	Consent Required	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	anonymous
474cf8ae-cd7e-4998-bde6-e0d0f851e9b7	Full Scope Disabled	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	anonymous
f68b2f99-3bf9-4695-a396-10524f37a233	Max Clients Limit	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	anonymous
9f8b0b8f-232f-4296-bb28-bbca1834a041	Allowed Protocol Mapper Types	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	anonymous
b4f9f751-c329-4e62-81f4-7446222659f4	Allowed Client Scopes	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	anonymous
b1f6e336-81a3-419e-86ac-80a71fed4327	Allowed Protocol Mapper Types	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	authenticated
4d21a749-e0fb-4332-8ea0-9a7e4083f252	Allowed Client Scopes	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	authenticated
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
44cb301a-a205-47c4-b994-982a9ad851f4	56bbbba0-843e-452f-98ae-f37ecb9c2b93	max-clients	200
c3d50554-8066-485a-b4bd-5b70dff31a8c	a0b805ce-0390-4922-8da1-ac774b2e0f13	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
44a163e8-99f5-44d6-9839-1dca7d4e5658	a0b805ce-0390-4922-8da1-ac774b2e0f13	allowed-protocol-mapper-types	oidc-address-mapper
684363aa-2c93-4ba3-b4d2-962454b23925	a0b805ce-0390-4922-8da1-ac774b2e0f13	allowed-protocol-mapper-types	saml-role-list-mapper
bb9d1878-7b69-4fa7-8bd3-8f246b7d521f	a0b805ce-0390-4922-8da1-ac774b2e0f13	allowed-protocol-mapper-types	saml-user-property-mapper
2c131d86-a2c5-44ea-8aee-1ac9b1e544ac	a0b805ce-0390-4922-8da1-ac774b2e0f13	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
c72a1476-ca79-4381-97d0-f35bb0fa6712	a0b805ce-0390-4922-8da1-ac774b2e0f13	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
d813463e-8398-4965-b148-ba0c318def37	a0b805ce-0390-4922-8da1-ac774b2e0f13	allowed-protocol-mapper-types	saml-user-attribute-mapper
8c5e1c57-c529-42a9-bea3-fd70fcb649e2	a0b805ce-0390-4922-8da1-ac774b2e0f13	allowed-protocol-mapper-types	oidc-full-name-mapper
60dd66cb-85c6-42f4-b9f8-86f1117cfc4a	50ad3834-b2df-4d56-a6c3-c013cecc5d62	allowed-protocol-mapper-types	saml-user-attribute-mapper
2d3c7f76-fe05-4ac9-95e0-5703accd9b2f	50ad3834-b2df-4d56-a6c3-c013cecc5d62	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
7785918f-77ad-4b06-bfd5-303bc7aa2b2e	50ad3834-b2df-4d56-a6c3-c013cecc5d62	allowed-protocol-mapper-types	oidc-full-name-mapper
11e7ddbe-a4f5-477c-b0cc-d65dcc5c17a8	50ad3834-b2df-4d56-a6c3-c013cecc5d62	allowed-protocol-mapper-types	saml-role-list-mapper
e83879b7-73a5-425a-8906-4392b573e034	50ad3834-b2df-4d56-a6c3-c013cecc5d62	allowed-protocol-mapper-types	oidc-address-mapper
8df42c59-72da-488f-993c-e74b46916455	50ad3834-b2df-4d56-a6c3-c013cecc5d62	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
e2add2b8-33d9-4a4a-9491-d40bea756bf0	50ad3834-b2df-4d56-a6c3-c013cecc5d62	allowed-protocol-mapper-types	saml-user-property-mapper
d0155551-2d5e-43d1-839c-55754d701e91	50ad3834-b2df-4d56-a6c3-c013cecc5d62	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
31c0f0aa-d2ff-4bf7-987b-6c491fd2c858	3dd31734-7126-43b9-837e-4d81d02e7259	allow-default-scopes	true
5ebb79ec-0090-410d-afbc-f2e26454897d	c1b1390a-c25f-4f0d-b559-ed7bcd32c609	host-sending-registration-request-must-match	true
0ef670f7-95e1-4b6a-a031-f304c35d84f8	c1b1390a-c25f-4f0d-b559-ed7bcd32c609	client-uris-must-match	true
792bff43-bf38-4ab7-9fc8-f0cbc912a736	fe694f9c-7894-41a9-88eb-13c634564f6b	allow-default-scopes	true
861668e2-d3f1-4804-8f79-933c45c63295	72139084-80d8-404f-835b-02836ac4b6ae	priority	100
ada50e98-a009-4fd6-9052-b06c68e55aaf	72139084-80d8-404f-835b-02836ac4b6ae	secret	OKQk0oSXHsTa-S34j6MDxxp_mwyAgHvKk-Blj9YWqj9YQ6L63b9ZT4BXxfEbjccHbRDXo5nozZuzPqdfTVBQUA
edc7b034-d78f-4e5f-9b0a-2987e127c9c5	72139084-80d8-404f-835b-02836ac4b6ae	algorithm	HS256
b1dda85d-dabe-4e5f-8349-17b1f75058d4	72139084-80d8-404f-835b-02836ac4b6ae	kid	255f52f0-8f3f-4ccc-9e06-693369fe4e4e
9950de61-3373-44e1-a50c-990306a9741c	be137259-8fb0-4a56-99e1-3c494282d598	algorithm	RSA-OAEP
4d2d02fb-b6d2-4a73-b6e7-442ad8fd4caa	be137259-8fb0-4a56-99e1-3c494282d598	priority	100
b38ae3f6-00e6-4cfa-bd6d-a4c035ce1b62	be137259-8fb0-4a56-99e1-3c494282d598	keyUse	ENC
ac35b5a2-372e-495d-9b6f-fc1cc7c6463a	be137259-8fb0-4a56-99e1-3c494282d598	certificate	MIICmzCCAYMCBgGDj5smtTANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjIwOTMwMTgxMjMzWhcNMzIwOTMwMTgxNDEzWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDC6oKHNsuG7u/lULo/aeFSzBhGlo2qa4IoFdNfM+i6v2KvKbsIdxeh7FguPL9MoVwWdhbz1Orggd9/hNEYO2cwBwzHPAQFSAfKFfWap4w9dHho26jdnWey2IC4GQ6wSpJqnPESOrW5tgK6S27RWkxCX5Tn0kSwhrFg3xkfdwDlfQ3dJvfBzJF4FbwRQNQXy3ZrteopnK2gdlFP1Z3IgYQG107Aa0JYziak/sl0zqMzyVrn/UVxZZMR6ykQeUnSObNEYhGiMHENUv3AfRs0+Qil+ZrTjrcq0VpewcPInTRVnM7EhLpZCMuW3j9yEXdUPFLTDsXG7+5LrAbwdfneVTxxAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAAzHzWZll0r8gPv9GRMw6H09TVhun+1Oz0VKuqr52bd8Ft1YEqdN/V9O3eqUyoqDa3tnJmw8seztgq8V3Vjn6Rei606wtb5v9xmDUxPdm0gkav5iN2s5ESLr54wYlaifRY44oTly3TdKlXMSCjhdy3bVPpQvYSQlBhaMutw6cChkU4JgW8uNVJJc523QEheTiwZPn6M+blgz5yDgvzw2a5aeCQ4guHsf8+4jOSQ0WSR+mxeAL94uhRJvW6hKrmU9V6DzNHPO0QECSsTtrbnYG8Qni6HGA4PGfRqIGE9K0n/qYRN6XhrxCfsVhGGLe1xMQPGa2hcaJhbSUXiuiPtH3aE=
a15f5c07-b4a0-4100-8bf3-9feef2d1defc	be137259-8fb0-4a56-99e1-3c494282d598	privateKey	MIIEpAIBAAKCAQEAwuqChzbLhu7v5VC6P2nhUswYRpaNqmuCKBXTXzPour9irym7CHcXoexYLjy/TKFcFnYW89Tq4IHff4TRGDtnMAcMxzwEBUgHyhX1mqeMPXR4aNuo3Z1nstiAuBkOsEqSapzxEjq1ubYCuktu0VpMQl+U59JEsIaxYN8ZH3cA5X0N3Sb3wcyReBW8EUDUF8t2a7XqKZytoHZRT9WdyIGEBtdOwGtCWM4mpP7JdM6jM8la5/1FcWWTEespEHlJ0jmzRGIRojBxDVL9wH0bNPkIpfma0463KtFaXsHDyJ00VZzOxIS6WQjLlt4/chF3VDxS0w7Fxu/uS6wG8HX53lU8cQIDAQABAoIBAAgoRdmwUKC/R7FuaTkFrp0nNv3fR6MB+FLCpRO3Ka6FG3VutuniCA5qBH+84ZmsqBy1iPzf5IuMS+T7kz+jHsyrAt0ktRteehr6Q8ra57rbsL1csgrCT2hz+KEbxVpZ6JpHIqyrYdcZl7Ahv4vJ7maZtvLjwSWtIWfHNnczZQl1mVpSYpGHYX/vwK83ICNzEcoJAl+4C5iYvc8eGxxN8JJfyXjVqSL616Anibaq4SOOrsJ7kocsrT6voyWnVzHzTXihamzK0y2Q+XbXaZ+/lhEJc9/E94bsbe0+jPNbZkK3tSwkoZc+Sn0CzftKIGBGz2cIcNtkhakJTiIhP9qS6QECgYEA8QblnAO/lohDXNPgs8opWHWnHukgi+vrVOMKUyWtHYA/PuszPAPxvQ9pV6SrdNKVb+lY0Mk4+g/N/68uMW0hKwzu2haUHsFdrJ+qF5WwcG1HG987YZWQeAOMCYF3ygUfhLS8o35M5KkX/rWma2G7PNtctmPGoo0Cy+jQYzl6nkECgYEAzwZNOO+MIDf4lQ0vRyXUN3qjcQsyb6DdLZR+XE72MzUxqYYyW3ES9UNulQFXNhX9ZyQKHzsFVWv4E2U28tilsDHEXki8FQf4rJehYqu/bguFNmMzjHmzJIQX9VJ6LXiam30e8NrKrKKQa+VELgBBCjjEG5VXWkzFE2oU5PJkcjECgYEAod/+75Q45TGpBDwsqrM4p3eFASaTPEX7LGy7b3JbXPfYAjrWkxUXEuG53ynyGSihQqMWikrKoG9i67jMrldbsl0iQYhufGVjs18cTnCzKh7KZja72+MmPuQq9etk92IPdAIquydFH0FNozx+g5oEtW+iScCjFGLeIPLAmhNtfcECgYEAuHN95CeSKraTtYFsyTBMNy3+Z165jjm+NrkiKG5170QKvmcBgPVrFbkB0qLCKD9Jalby6cZ1RxmOiwFYBuC+JxEAS5z0bqyOhIAI21f4lDyRcNbL+/IGiZdjnUDh+JeG8Nh289OMVmn00R0RNQcm68uN9qGFlb/mqxiOCzpoAlECgYAVR5JXlbGLp3wMIalHc2R+TnVvd8KwsgCo6I7xLdGx9hJyG+/1gZ182bY1k6EXvP9OiUTx3SHu0LQzP53Fz0vZEkkaVNI/RXFIjRgba9//cVcbwmwY+V3OnWc0Msbla0n9SUWLdEZ8ClpKygqyv04UEG12gHbuS7+AURcQCYp3RA==
bfe9d6c0-1718-41ff-b425-87e38feaea69	43e9e0f2-afaa-4e12-b704-8e06e5f7ee20	keyUse	SIG
10fc8c39-25c0-473f-a081-3646e606869e	43e9e0f2-afaa-4e12-b704-8e06e5f7ee20	priority	100
72d71286-9cd4-4a50-b7f0-6bb660839993	43e9e0f2-afaa-4e12-b704-8e06e5f7ee20	certificate	MIICmzCCAYMCBgGDj5sl4TANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjIwOTMwMTgxMjMzWhcNMzIwOTMwMTgxNDEzWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCQHgjC2191Nw3k4xzvvuSr0o8OXoN7fsEQJT/Yywv4ROnWjMXlI3+QIdm/hbB+kF4FJ1hzgp2Kumt75NlrAOL4Z3qBE58m8g3RKByrqbpRQ14WDmbl9NZD13kGiHqNIxMSUjYICztuwXHffl41bVS7v9m6yPdtvPGUe6eysg819rLHQaJZv8AAQxN9WSRoggTylnfjL4vju/Mf0EV2nL/2Ob72ouZdl7LxmJ9pC5VjF8tJH2EWBVTeUHkhrcNA3HRy3OlExSDpX0hP5PCneSI3LaWtMwylxNkPoO78AZxQKZjuKLSFqRefh2WUNW1a/W6Ggj6YqZyeDLP+i7Zf8xM3AgMBAAEwDQYJKoZIhvcNAQELBQADggEBAAmf+Jc2/lVVK3/7gUsCPgKyoDUyvYdUeybbF0wOygIREqaaix2oXi53T24Ibszbkq4/btWuRtoHfFRDfCR2SV2FtXJG1OsOyvHwdd+xRonV3CO3zC0Frb933Th5rvjyoLpCjIxPAdMAEN5dNvASbMfQ827KgOiSaQ3MgbXXdBJG0soiAoW2EmIwn6PC5G5o8a/dQR7yjtCF9Rjf3TINlXkDg1CUGtZVHwNGEGaDUB6w/khHQrfe3yRO9BRtD98oNsneyAc1QeKv1Mt6iWyTolkYMHQX/coAGUVgR+VJZDDou4miYsigFMDlhdFaY58jCQhDmN+iCxV1tQ+wtgLSNYY=
7647d9f9-9f52-4966-a6d9-9d1f7b9c2fa9	43e9e0f2-afaa-4e12-b704-8e06e5f7ee20	privateKey	MIIEowIBAAKCAQEAkB4IwttfdTcN5OMc777kq9KPDl6De37BECU/2MsL+ETp1ozF5SN/kCHZv4WwfpBeBSdYc4Kdirpre+TZawDi+Gd6gROfJvIN0Sgcq6m6UUNeFg5m5fTWQ9d5Boh6jSMTElI2CAs7bsFx335eNW1Uu7/Zusj3bbzxlHunsrIPNfayx0GiWb/AAEMTfVkkaIIE8pZ34y+L47vzH9BFdpy/9jm+9qLmXZey8ZifaQuVYxfLSR9hFgVU3lB5Ia3DQNx0ctzpRMUg6V9IT+Twp3kiNy2lrTMMpcTZD6Du/AGcUCmY7ii0hakXn4dllDVtWv1uhoI+mKmcngyz/ou2X/MTNwIDAQABAoIBADia41wNqA+1AQsOvVXZR53JRREixEfkQFZkGxC+p8Pq5WG0xyG58Kee9BTKoMkFUTh6/L3Z5qEPmZn/B/qETaG9mxtJprA4UH7/X0t5jcnPSQwmufnGUcYxwsJzJpd62EnQ6pH8P2rAJkbfLoeTmr1nnFBGEREULlrgurxwPZM27Jk3miClXnw/JuH0UfqyuKZZE4Vd95cpdOIFE6/wdTfiZ8zge+5N0yBdakaNahNi+GLwxNJClbqhsyIumaQEYWQcSSSewqnmo9DdKkBhYJyhoXVDohuLxqCG3CcYr/oyv3sAqXSehIW2HP7PNjz1SepiaejJLsIaa/BFok8+d6ECgYEAwnXw3Kh2jmQrvWOPsrkP4UhKlDtjgUsPvmZS9leZ6t1MtV+9ZW6C/43OmfzHq0ATJ+8kpQ1BVfzCkNwOwzA35QNEiGJ0r0pmj5RZp4AGC6DlqZjiDQQbNQQmVCUUqGHcs739nGuFM286yZ/4kgDw/SMgY+Xxs08DnYIkEZmjtLECgYEAvbmRva8ki1lsB1BI4gGqftUX7UIVFuhDir76ynYt9A2ufr3KGLXHZvV4qbLMxka7IBDC2stmSCpPL2Q0juwIw6nRWiRhnc0QjZ1zNQykFBc39khHf0bS+ztKbGVSqXPEm+8iliAMRSHm9kR0LoCICJGdQ55FJeRmqXq6djFDYGcCgYBhWPmC/TKchbj/zl+ZcNtqQ+5R1okxqInxHvhZKfF7id1kztDZfkFF/Y93tvud1y2/yA/oMIKMsUQVkJQzUmgo1UHxpJgVSIGfTvyyxXxBRgKyrD49ldio6bLmXMnCoXsC4BGdxJWh8gTT+qlNLft2PadxWyNsSBnfN88moGs7gQKBgQCyO2V1u9Zp7oy05jBB2WzRD+EVa5IiXfotmrJBhvounrfBqwvzYLm9uHctfKIw1nuuaPCU2KXyv4R6MfnKFmU5YwwgUbM+qkmVsEdtm718fj99Z3N7Vw6XI6EL6bfZJr+Z+fIU9HBydaHi0nYOxYKGAj2qK0Iskb/8ESagKDFymwKBgCnRI8CLq4SD961ZdnZS+M4qC7yvll6V/L4dUZfyq4UsnF+vr9h1it6S98ZBt7UJqdSG6a9H1flhRX2J+LZrIOn00m0f0LYX1cBZt41pFHqGgY3eHqRRKX3LoIv3XLVl3u7gsHIjpMAJrhBATCGEsjhrbRJdVDTtgnQJn/IBagiR
f6701125-9f71-4f09-9f94-497af7513f14	c3a7d23d-9c78-4a14-bf3f-6ac9960e716d	priority	100
64a1c5ab-173d-4756-a98d-2892deca5d43	c3a7d23d-9c78-4a14-bf3f-6ac9960e716d	secret	8Je-wUoYSTuuUNT1eXLbew
61171617-0fb3-4702-9c8e-1788e08cd03e	c3a7d23d-9c78-4a14-bf3f-6ac9960e716d	kid	39732f63-2a75-4405-b9bb-9bd3d8afc8cb
f6d9d310-7b63-4a1c-9194-5de13c099d27	b69de475-3b1d-4bc6-8b05-8a6919e50abc	privateKey	MIIEpAIBAAKCAQEAovtQMdvwjKQJXNYjE2DIdJOL5F/WYXntF4v5Ed33fEimiQ5Mm+POXuesTHbQRduyn/Z1p7scKEbCjanyUPDACCHl42ox+JaqzjoRWiF3wt9/ehPGa+VfUd7HpV80q+0M8WLGf6ktOlhOKfrQ17WlGrg7OqOK1nzYew5E/JS87duxEHPzRbHYsNp5mVoRXMdOwL9pBiE6t4NZo+I6Q7xeLgYox3JoiNJRaBNpUNbkDm6FcWvbkHXMFQAYJ6RrD58sDa/TYXF38F0hqN1v3WQcy7otrkTVAUo4+ZWbpLlZDhg/Pc/1jpvcoz/zDSvXHjoRU/VrA7Y16MQQdIGip9O/VQIDAQABAoIBAAHZ2lQA21HjXO2GZ9gTMOZJ0UAMw16s+zv9MuQYsgJh7BEosWM1vgpL8jldF01lI8fJBkEbYtJJDsdRRIrkSYUlPEzKbHAkZwZ7n4M3SZb+r95OUHeAZr8m+xhsTCHeu5dQjtdmKJyIjQrtu7iFOGhWzlvX75dPhQ9Uftoig1ACj9SSk4rRqEPQyT/XlIeZMzUweAdxUNsdEofguO8Ck3a7NFfYuKIuxeD4cGAuaxKuqNOPm/GW07sqq3lnTV1jm/SduD214/c/PA8X8Gj3yqxmFtyM++K19oltm3teEH8hZkqx0d9vLtWCpOpCrxqSVRwh9ql8ANKMs6OuU0K8B4kCgYEA2tW5GZVt7nSdVyceCmYSY9snTs9F7DvPq4vUERN/cQNgZE4Kkb5gdSKZv6xEg4aRiMjlH/3WHVEgp6J+/5MgPhb5tjIdA0o+VbiWGhYz9xR+l+1WFdAMEUFOcBrtXv2UkFWDoPg6kPp+MnXn461S8enZAm0ZcWaRtQmGiDr1o4kCgYEAvqlDh2XFVWSbKXjbUVZveBrpZhz6+wZChTXX+l7FtfZ92CNSI557DKLXret+yjOrb9K12f3NnQQSWirI4gO7fRT3TW2TrkxgmFReA91+hKLlvRFryuyybaxwUk6/HbhPJMzgwfNtNnCsNHnJLkDvVYV3sP8/nY7KRwggxpPmrm0CgYEAtIrBRKcw5BuXt9CRCzk9EN885dtBr+2Ent4k3tW8PcvwWbC9LZLoV5ttR2JjwDNknHpJ9oPgg51sGIGKz2ZdonwoFrXvk8hL90Lrq6gHxWBGNSfc7vAPFKlRglHk5orFZ/L1PvessfHH7e+ymfdkSCuLG2JRLGrX6YlrUbd68ykCgYEAoukCOGjvKj3ijpcj3uYaLOfh0kyk72Sz5hrRxq7ABPDvKoVTo/fAcFWcMJFuLtvjepLyq6c/zxAxljXEm8pQo1oMzW35qA6+4qoEAw15E2AVKW3/Ss7gzvFusAV1K7HWfj1JNrAG+2Ne4R/GlO0LE2oNkYEoHDpsADGjv8mUbCkCgYAyqVhFP8JO21K05ZK/8R+bg4tExwupOoEK8vssXFmfftjkwUqNryz2kiNOK0/3BgXevXobQ0EmSSkLe821jw29weNCQUhmxP5/ldZo8NWPnXgduPpe6Hu7jWpYreYd89RKNQz8QDZMKyH6O9T+5J4dkhJ3wfq3jRosh9fZcXyqow==
8e0aa6b1-2391-47c5-b13d-161c26f4c768	b69de475-3b1d-4bc6-8b05-8a6919e50abc	priority	100
ad2e5f20-b808-4c23-b94a-8ef0873623d6	b69de475-3b1d-4bc6-8b05-8a6919e50abc	keyUse	SIG
36c0300c-74d6-40f4-ac9a-3354059806d4	b69de475-3b1d-4bc6-8b05-8a6919e50abc	certificate	MIIClzCCAX8CBgGDnvQLTjANBgkqhkiG9w0BAQsFADAPMQ0wCwYDVQQDDARtYWluMB4XDTIyMTAwMzE3NDM1N1oXDTMyMTAwMzE3NDUzN1owDzENMAsGA1UEAwwEbWFpbjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKL7UDHb8IykCVzWIxNgyHSTi+Rf1mF57ReL+RHd93xIpokOTJvjzl7nrEx20EXbsp/2dae7HChGwo2p8lDwwAgh5eNqMfiWqs46EVohd8Lff3oTxmvlX1Hex6VfNKvtDPFixn+pLTpYTin60Ne1pRq4OzqjitZ82HsORPyUvO3bsRBz80Wx2LDaeZlaEVzHTsC/aQYhOreDWaPiOkO8Xi4GKMdyaIjSUWgTaVDW5A5uhXFr25B1zBUAGCekaw+fLA2v02Fxd/BdIajdb91kHMu6La5E1QFKOPmVm6S5WQ4YPz3P9Y6b3KM/8w0r1x46EVP1awO2NejEEHSBoqfTv1UCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEADoOtfPKJgYbVd+QfoG6Z1abdRGE4qDzkIoRA/lqXPG8SVE7LctUrNEFajGbtl78i1OVCDjKj2I56+2+yGYvZl7zolKN/4ZG1fK0Nhk9rtdXaNhzQ5y/ptjKBzz2vCkFI1pbb/mif3OIDqThPYNY12wYmAU1Y+60v1m58nvBDm3WC+uKnneqexz+lKcQzaH1Ms+pf5DtplqdPDoAeZg8jvoi7x3q8pyhFYya+pUPt8XmiHqQKQ0QZJmK2EVrfoY2K9l4MdXWjt5gpEpzdtc+zOGv1rVjypI3zR2BPPntAAlOCHwki1X+445YivxxlHe6pf+AzN2AZUwPW7+z/PqWRWw==
73dfdc52-dc39-452d-8dbb-0880aa29a283	6fbe1728-6b6c-4d87-9c61-f660eac5c7e8	priority	100
5fc703a3-6349-4ecf-acbf-9262a803b105	6fbe1728-6b6c-4d87-9c61-f660eac5c7e8	kid	f9d23217-2c8e-42d7-a74a-c3362e4672a9
52ce51ba-8c3d-4dd7-aea0-7b2d9b62e46f	6fbe1728-6b6c-4d87-9c61-f660eac5c7e8	secret	KvdwHYDoZEzMannqtIEnKQ
22f52507-687d-47fb-8669-10492a36ea68	3902e4ee-a121-4eac-b773-044c06a2b820	certificate	MIIClzCCAX8CBgGDnvQMRDANBgkqhkiG9w0BAQsFADAPMQ0wCwYDVQQDDARtYWluMB4XDTIyMTAwMzE3NDM1N1oXDTMyMTAwMzE3NDUzN1owDzENMAsGA1UEAwwEbWFpbjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALxovVvDGGXw7yWvwwZbSloSxs5cvzf4C3pKXsOBdaH9yECsMIbeQZwN33UHgx7hRHvhEdoTSAO8mmD1F6vqecKJTeOGxc3YI0Ie9R88IwQCRBf10FjbfMf8tQDCIAmH7OFZ44dog16W+dWVW0DWOIS12ZUgWNHMPUgRKKWUr0ZxWYwedjPNB2WQsTOUtHcgLj7krMja5IuSsT8OIZNdDdei9fSzHrK4PPWliSvYuBwmF8610O0EiSZYlmpIIRdzXZ8j3q2zyq8XFOiKfDL4YbnEVR/R0m9DWiut0HiG0w2Gd1zI11GA5S//NMH3c3kwVPD4iNJALb4sdkT2SVPYGuUCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAqIWQfFoHvHo87ZF0bQVWbNV1mV3sm/s9a+4QHYoQ6csEgcc5PUFRndnHnnz0ZxuIJHifwdq+dLWpxhB1eVe2I3gxg94nsKDPckTeUk6v54rZWFSLKW9ynI7g2A2I3kyYDq6xCh7XLx4zkUok99dFwvAUOXWI/yf2mG72msE8afybLkRj6B39pK4mk2T6gZo1GQtd0SdGZh3sI1xJS3/lQbK5W0xbtdxIH67vMNrgCiU2/Q+2iyTbIZ0CqT+GJqYNFmAFoqf/oORIllM9/L02pvXLOYaHoXq+zhbHuUXoZhNboM9O9KCidu25CbnGmOgS4qhbD/p2AURpz6gNBQfFiw==
cf1d7d76-0570-4a46-9df4-18d2baaa1ed3	3902e4ee-a121-4eac-b773-044c06a2b820	priority	100
86588d13-47d3-4f77-af14-dda4dc365f70	3902e4ee-a121-4eac-b773-044c06a2b820	algorithm	RSA-OAEP
b4f66d78-d843-46fc-8fea-9023439e6b5c	3902e4ee-a121-4eac-b773-044c06a2b820	keyUse	ENC
190cd014-0565-4fa5-94fd-bde2fee53a38	3902e4ee-a121-4eac-b773-044c06a2b820	privateKey	MIIEowIBAAKCAQEAvGi9W8MYZfDvJa/DBltKWhLGzly/N/gLekpew4F1of3IQKwwht5BnA3fdQeDHuFEe+ER2hNIA7yaYPUXq+p5wolN44bFzdgjQh71HzwjBAJEF/XQWNt8x/y1AMIgCYfs4Vnjh2iDXpb51ZVbQNY4hLXZlSBY0cw9SBEopZSvRnFZjB52M80HZZCxM5S0dyAuPuSsyNrki5KxPw4hk10N16L19LMesrg89aWJK9i4HCYXzrXQ7QSJJliWakghF3NdnyPerbPKrxcU6Ip8MvhhucRVH9HSb0NaK63QeIbTDYZ3XMjXUYDlL/80wfdzeTBU8PiI0kAtvix2RPZJU9ga5QIDAQABAoIBAAE4qULp2gPN0txgLiKhlIhOnIT5m0W4xmjwXXqP9sa/jJJFa3pxq2Q1v3qUkLgyW/gfm+GELtB+Dal45+013mcxQ6oov/8sb6y94vc6XmcSwAVAaILYSA/10T3kLu1Q48C24p+IlmgWZh/efCfIm7eEhENlYR4EYGtSAnzxoKHowahTacPo+rhZ5KbVbMyAc8AAkhtzOO6saYa4xC18qGqa1vnFE1J5W9ew4TEsurV83devIjOgSrdfGCiXJfnyxecm7JvMomQlizyZ2KKCFJwia52WE2FVbdkBZP+mjWzeCBAXH5aTsUN3fNNwG/P4NfF/sfsoUGacnyez7zwsv+ECgYEA+e+W1ep9geINTF1DZ5z/dWOqJpeRDe6dSu5iySiwW8lFGEs6LUDfar4vJbHjuxeoDjaILpVrm5lbe5ZSHoMqfiVuZ6pa77yC2v5ecYyFvFIKC1x8sKfZlT1Q6DUWTgRoFiDc/rg4oXEHJexTqnmXucdYTsvCTP508X87GTI1uFUCgYEAwPr+SANdAFfbkjIqjeAaV/eoh/zdiya+cZVJ4w97PbLR0NdWvbFPpEob+GIzukz1Whwo4dv4VRkBAOfcwvKj9Bvo1EeYNpKbBoHGD9wmPzy5iO4ztV4TMDs/enbuHSMoEDZ8ddqx6hCrWk2xz5RWRfiIIpz2DzFkTQnFEVVdqFECgYAD7o/554l37J128RSpYZ/nMd0wZDwE8xcIYb2uGnTDzOPIYQ6WPaoGHN3TAvxpKhMbviHgUbtypDP7Or8p+bhGacJV4SkzEk0gstW7hZFpCAVebmMLyGg039URAhzKt2kHyBaR70X8zDFnmFMsoGMRqiAqhSwWV/5w+iZs3AxaTQKBgQCyaRmfICTiBVfE0EZRRid0vkz79AYp+JbG0ZsupYhtoR2jMwJJe1zC6ZT0TG3ARhfqx+/v53qtyeEIolORk9uJ+ieF4e7SPTW/jUi8Lu7ZNd3dv0Lk4WViCNSF9t/q5i7K1mS4XIhxehnA8eV6oIwmQkAxp+VAZIxzQJ4FiWN+EQKBgBMEh6nGQm9yPrhaHGxE5zdyroecrvMWhsCSDQ+yop/KZLuPY0yT4Abs+v96FhWcwEb9I4mNtB9fzC0Q/zHvg3mgL97gWkWTBKKcF/QvHX+CH73eDWfQQJzUdcEdxIYDkpQk+86jz0eae4K7ZnRVjp7Azt8omvHx6JiwPw2gABkx
7fc217e8-92d5-411e-805a-b4a993c84191	52e4bb53-e328-4869-b4d5-0f4ba268b5b0	algorithm	HS256
6cbad58e-fb26-4d72-8919-8c89dbee44c0	52e4bb53-e328-4869-b4d5-0f4ba268b5b0	kid	9c31e8f4-e11e-4dfd-b97f-812fd6141782
0f5f8358-8228-45e1-85a1-18cf459f2fa9	52e4bb53-e328-4869-b4d5-0f4ba268b5b0	priority	100
21ea9917-aff1-45b7-b694-814501214a12	52e4bb53-e328-4869-b4d5-0f4ba268b5b0	secret	z-SIVpEoD5RHMwxLzdaY-o6_Tx0NTyvacch8V8wO6mg80ETL7UQZrPdsgfYsqC5jEwuFLpyJzXnpmHVPzqgrow
e778375d-4855-48bf-b7ea-4a4b06a3eced	dda0d922-aedc-4378-9ec2-5fe1962acbdf	host-sending-registration-request-must-match	true
50649362-576e-4d16-8883-4ab80fb2a71e	dda0d922-aedc-4378-9ec2-5fe1962acbdf	client-uris-must-match	true
ecbb8184-faba-4e42-8d8c-98b071a08a93	b1f6e336-81a3-419e-86ac-80a71fed4327	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
a35f619b-7016-4cc4-919c-104c9085a03d	b1f6e336-81a3-419e-86ac-80a71fed4327	allowed-protocol-mapper-types	saml-user-attribute-mapper
73f74625-65ab-475f-8240-3ceeb5e9306c	b1f6e336-81a3-419e-86ac-80a71fed4327	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
6441cec1-4dda-4e79-90f2-be04c3c2faad	b1f6e336-81a3-419e-86ac-80a71fed4327	allowed-protocol-mapper-types	saml-user-property-mapper
05c4fe67-81e4-4c57-b740-36f492279907	b1f6e336-81a3-419e-86ac-80a71fed4327	allowed-protocol-mapper-types	oidc-address-mapper
4d4706ae-96b1-4c91-9961-725290661773	b1f6e336-81a3-419e-86ac-80a71fed4327	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
4566bc99-8a65-4972-aa7e-c1449aca6c8f	b1f6e336-81a3-419e-86ac-80a71fed4327	allowed-protocol-mapper-types	oidc-full-name-mapper
6b7fef14-b62f-43fb-8d17-8c6fccccd189	b1f6e336-81a3-419e-86ac-80a71fed4327	allowed-protocol-mapper-types	saml-role-list-mapper
80a7898f-b449-4d9e-ac69-f4a2c7d5ff4e	b4f9f751-c329-4e62-81f4-7446222659f4	allow-default-scopes	true
71a36d99-bf88-4bae-bcb0-6bd560fd9d63	4d21a749-e0fb-4332-8ea0-9a7e4083f252	allow-default-scopes	true
048d8538-3cb2-4755-a979-ca6f853f48d1	9f8b0b8f-232f-4296-bb28-bbca1834a041	allowed-protocol-mapper-types	saml-user-attribute-mapper
304edeae-8470-4d76-9ce5-e9970b9b2d4d	9f8b0b8f-232f-4296-bb28-bbca1834a041	allowed-protocol-mapper-types	saml-user-property-mapper
8e7670e1-a6bd-4b28-b495-3c75c1369b2a	9f8b0b8f-232f-4296-bb28-bbca1834a041	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
f48643bc-94ea-4bdb-b359-2a70d26ca594	9f8b0b8f-232f-4296-bb28-bbca1834a041	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
3ff57115-cf30-4a8d-a99a-6c1da34cc7df	9f8b0b8f-232f-4296-bb28-bbca1834a041	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
ee46dc8d-3786-43d5-8b0a-876354cd72d3	9f8b0b8f-232f-4296-bb28-bbca1834a041	allowed-protocol-mapper-types	oidc-full-name-mapper
1086650a-5792-42ba-a26a-cc0e125d21fb	9f8b0b8f-232f-4296-bb28-bbca1834a041	allowed-protocol-mapper-types	oidc-address-mapper
e5ecc90f-c290-4e03-82b4-8a91ddb0e72e	9f8b0b8f-232f-4296-bb28-bbca1834a041	allowed-protocol-mapper-types	saml-role-list-mapper
47ce5e99-af24-4864-957e-cdbf06b74be3	f68b2f99-3bf9-4695-a396-10524f37a233	max-clients	200
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.composite_role (composite, child_role) FROM stdin;
b872bf24-9567-43b8-b17f-8a0c8b9d480a	c79acb00-7b8a-49c4-9cdc-a919ea39dc12
b872bf24-9567-43b8-b17f-8a0c8b9d480a	dec7a32b-1484-4371-aeae-b658fdc87884
b872bf24-9567-43b8-b17f-8a0c8b9d480a	7a1efbe9-7e56-4fe0-9f96-4b0d15429762
b872bf24-9567-43b8-b17f-8a0c8b9d480a	67fd17db-62a0-4088-8108-00e1a21048fa
b872bf24-9567-43b8-b17f-8a0c8b9d480a	9df49db9-322c-4827-8fe5-88d33b9ce5bf
b872bf24-9567-43b8-b17f-8a0c8b9d480a	00150b33-814c-40ba-8a0f-70f2128815f7
b872bf24-9567-43b8-b17f-8a0c8b9d480a	c03ac27d-728e-4be2-92dd-27995593841d
b872bf24-9567-43b8-b17f-8a0c8b9d480a	f397c451-2494-4389-b6e2-94716a16c5ef
b872bf24-9567-43b8-b17f-8a0c8b9d480a	84609663-3229-4110-bcc0-e8100d341c21
b872bf24-9567-43b8-b17f-8a0c8b9d480a	f8c4b0cf-a01b-40d4-9506-8f281aee450c
b872bf24-9567-43b8-b17f-8a0c8b9d480a	9fcef069-45cd-493e-8600-ee3ce6e8e29a
b872bf24-9567-43b8-b17f-8a0c8b9d480a	3cae7d36-4c78-4e31-8970-8fc190f4ca07
b872bf24-9567-43b8-b17f-8a0c8b9d480a	78a2fff5-fa5e-420a-bb7b-456602bd03ee
b872bf24-9567-43b8-b17f-8a0c8b9d480a	72d17e55-d9b6-4944-b543-30801ac54f79
b872bf24-9567-43b8-b17f-8a0c8b9d480a	e241caa7-55a9-48c9-8b5d-f74e8957ac87
b872bf24-9567-43b8-b17f-8a0c8b9d480a	774275b9-1a27-4e73-a0b4-96dd1fa768bb
b872bf24-9567-43b8-b17f-8a0c8b9d480a	9e30e8a2-0374-4c52-b3b3-f237ae65ff4d
b872bf24-9567-43b8-b17f-8a0c8b9d480a	ce31a9d8-92c5-461d-a36e-22325f8e30c6
67fd17db-62a0-4088-8108-00e1a21048fa	e241caa7-55a9-48c9-8b5d-f74e8957ac87
67fd17db-62a0-4088-8108-00e1a21048fa	ce31a9d8-92c5-461d-a36e-22325f8e30c6
9df49db9-322c-4827-8fe5-88d33b9ce5bf	774275b9-1a27-4e73-a0b4-96dd1fa768bb
a262068b-d0e1-415e-96a2-ba6a73180eb1	05af7506-90b6-4dfc-b0a0-4482fb1a5cea
a262068b-d0e1-415e-96a2-ba6a73180eb1	654969e7-5e26-4b96-b55e-fce2dc2b7e7e
654969e7-5e26-4b96-b55e-fce2dc2b7e7e	16022a41-41a7-492d-b0da-70b88826c098
b3dc1a34-97ef-4f90-bc86-165babfc8ac7	497dd88a-d892-428c-86cc-26d14d416163
b872bf24-9567-43b8-b17f-8a0c8b9d480a	22ffc36e-c621-4d87-9e2b-3fedf603cede
a262068b-d0e1-415e-96a2-ba6a73180eb1	c46487e1-9957-4665-8130-18e4b258d37e
a262068b-d0e1-415e-96a2-ba6a73180eb1	f4cd14fa-0a11-44a8-806d-e611ceb766ef
b872bf24-9567-43b8-b17f-8a0c8b9d480a	4aca9eb3-6030-49d7-b5ab-4cd1ec91d21a
b872bf24-9567-43b8-b17f-8a0c8b9d480a	646ef6d2-0354-4585-aead-8ed91fff8534
b872bf24-9567-43b8-b17f-8a0c8b9d480a	bf1a9ddf-23b3-47ba-90f4-1ed2659a3471
b872bf24-9567-43b8-b17f-8a0c8b9d480a	c6cfbe04-0471-49e4-a569-cd4150ff7c8e
b872bf24-9567-43b8-b17f-8a0c8b9d480a	de1cced5-43fd-4334-965e-5929fc2eed87
b872bf24-9567-43b8-b17f-8a0c8b9d480a	fdd868da-74ee-446c-97ce-eaf3e96c6687
b872bf24-9567-43b8-b17f-8a0c8b9d480a	57889376-837a-4ca3-97a5-56ff0bd19c02
b872bf24-9567-43b8-b17f-8a0c8b9d480a	8c29e340-4cd2-4d81-8429-62c878efbf69
b872bf24-9567-43b8-b17f-8a0c8b9d480a	05a26056-a4ac-4521-b25b-4e9748e9915a
b872bf24-9567-43b8-b17f-8a0c8b9d480a	11ce42e6-bd6d-472e-8c85-bc106480e710
b872bf24-9567-43b8-b17f-8a0c8b9d480a	6c34b098-d27c-4e49-bb82-6eeb7998e6c9
b872bf24-9567-43b8-b17f-8a0c8b9d480a	c01d8979-3356-478f-98a5-2bc24387e624
b872bf24-9567-43b8-b17f-8a0c8b9d480a	757c0431-8cf5-4276-8db2-00d4b659dec4
b872bf24-9567-43b8-b17f-8a0c8b9d480a	044ab6cd-2427-4bd7-9d6c-7b950a63cb4f
b872bf24-9567-43b8-b17f-8a0c8b9d480a	ab21d099-4d59-4521-beb2-51eff11e53ba
b872bf24-9567-43b8-b17f-8a0c8b9d480a	34d0083f-cdd4-4ab5-af31-7c8aa873eea3
b872bf24-9567-43b8-b17f-8a0c8b9d480a	f2284e81-8447-4ba6-b706-3c35de78af89
bf1a9ddf-23b3-47ba-90f4-1ed2659a3471	044ab6cd-2427-4bd7-9d6c-7b950a63cb4f
bf1a9ddf-23b3-47ba-90f4-1ed2659a3471	f2284e81-8447-4ba6-b706-3c35de78af89
c6cfbe04-0471-49e4-a569-cd4150ff7c8e	ab21d099-4d59-4521-beb2-51eff11e53ba
b872bf24-9567-43b8-b17f-8a0c8b9d480a	b9f1daa9-d3af-45a0-b3c7-18ea6df62665
def4fa49-81ef-4ab9-98ec-95c599c738f2	de0b898b-defc-494b-9178-b2b2864a9646
def4fa49-81ef-4ab9-98ec-95c599c738f2	05a332db-0e3f-40c6-a099-daa630e1c15f
1f253b45-9c30-4271-8525-5ff99ed4d172	50d6ecab-247f-4922-9344-84a8ecfc83e6
1fb0b090-9878-41f0-a857-d273e06d9c84	6a0346cc-e003-4584-8039-72b8dc522e06
53fcd7d7-bb16-4a47-8eba-bab5d5deddb3	db003945-aaa8-45ed-89fc-86803b34ab9b
c5a7b6e1-aea2-4d52-98e5-ff294b90e116	62effce6-7be6-4a48-9a83-3d94c4b31555
c5a7b6e1-aea2-4d52-98e5-ff294b90e116	a7adbf98-5c6c-4993-83ca-d69358ba204e
e602022d-ea8f-4347-8340-a5c7566e0125	90e4d2ca-a323-4918-a25a-e66b866e9a04
e602022d-ea8f-4347-8340-a5c7566e0125	216d4630-d140-4b06-9be7-ee52cf105d59
e602022d-ea8f-4347-8340-a5c7566e0125	dbd4a13d-d2a4-4cdd-a47f-bfb6d7b8df7e
e602022d-ea8f-4347-8340-a5c7566e0125	a56a0a0d-a808-44f4-b1fb-2b564e51e72f
e602022d-ea8f-4347-8340-a5c7566e0125	6d8244f7-4de1-419c-b586-9b1c7aa4cc1f
e602022d-ea8f-4347-8340-a5c7566e0125	c5a7b6e1-aea2-4d52-98e5-ff294b90e116
e602022d-ea8f-4347-8340-a5c7566e0125	62effce6-7be6-4a48-9a83-3d94c4b31555
e602022d-ea8f-4347-8340-a5c7566e0125	7c7bba8b-2382-4350-bb32-c0c211fe1f3c
e602022d-ea8f-4347-8340-a5c7566e0125	a7adbf98-5c6c-4993-83ca-d69358ba204e
e602022d-ea8f-4347-8340-a5c7566e0125	a532a69f-8925-48cf-ae42-c660d3d6fc4c
e602022d-ea8f-4347-8340-a5c7566e0125	fa057fb0-f14b-42f5-b07e-2aa9872429fa
e602022d-ea8f-4347-8340-a5c7566e0125	7e8f6ee5-8dda-40ed-9ca3-7aca90eb4f1f
e602022d-ea8f-4347-8340-a5c7566e0125	97ba89cc-d6d2-4688-9ef0-a3a7dce1b7ab
e602022d-ea8f-4347-8340-a5c7566e0125	47a6d194-853d-4b53-afb0-151e0c1cddf3
e602022d-ea8f-4347-8340-a5c7566e0125	d3e4633f-8c2a-489b-a656-e7e888c1deba
e602022d-ea8f-4347-8340-a5c7566e0125	1fb0b090-9878-41f0-a857-d273e06d9c84
e602022d-ea8f-4347-8340-a5c7566e0125	a3f7750e-3864-416b-b9fe-92ce4fb2413a
e602022d-ea8f-4347-8340-a5c7566e0125	6a0346cc-e003-4584-8039-72b8dc522e06
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
5a99e3cd-429e-4365-9dda-94fd52c47df5	\N	password	2bac2a87-2459-4520-b8d5-2a6ce297f99d	1664561654323	\N	{"value":"CL/0AtEI1ItEMhhXb4Cp3lzA2yfVg3a4apkIok3lwCUJuFpfpJVYvMSjGf2T1z99N0eyyQqssINgK8un2e07xw==","salt":"T4+8gSwUuwoN6qOp8qrMHQ==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
8100610d-a6b1-4c77-a17a-c2a6363df297	\N	password	36b0f7be-6a1b-4a83-bd29-496f2d42e8fc	1664884720259	My password	{"value":"GqDnBeW7HUmwg9WRLy/80fK5lbWDOLZAsuJQldHucMu5O4XJE6EgYex3/J+VewEBFNBvyr/JNnjRXPyPzrnaYg==","salt":"FxqbR3Doi4iHIc7xTjQWlQ==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2022-09-30 18:14:07.00936	1	EXECUTED	8:bda77d94bf90182a1e30c24f1c155ec7	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.8.0	\N	\N	4561646186
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2022-09-30 18:14:07.020872	2	MARK_RAN	8:1ecb330f30986693d1cba9ab579fa219	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.8.0	\N	\N	4561646186
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2022-09-30 18:14:07.099686	3	EXECUTED	8:cb7ace19bc6d959f305605d255d4c843	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.8.0	\N	\N	4561646186
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2022-09-30 18:14:07.109846	4	EXECUTED	8:80230013e961310e6872e871be424a63	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.8.0	\N	\N	4561646186
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2022-09-30 18:14:07.647219	5	EXECUTED	8:67f4c20929126adc0c8e9bf48279d244	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.8.0	\N	\N	4561646186
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2022-09-30 18:14:07.67001	6	MARK_RAN	8:7311018b0b8179ce14628ab412bb6783	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.8.0	\N	\N	4561646186
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2022-09-30 18:14:07.846461	7	EXECUTED	8:037ba1216c3640f8785ee6b8e7c8e3c1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.8.0	\N	\N	4561646186
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2022-09-30 18:14:07.8509	8	MARK_RAN	8:7fe6ffe4af4df289b3157de32c624263	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.8.0	\N	\N	4561646186
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2022-09-30 18:14:07.861103	9	EXECUTED	8:9c136bc3187083a98745c7d03bc8a303	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.8.0	\N	\N	4561646186
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2022-09-30 18:14:08.043913	10	EXECUTED	8:b5f09474dca81fb56a97cf5b6553d331	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.8.0	\N	\N	4561646186
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2022-09-30 18:14:08.17495	11	EXECUTED	8:ca924f31bd2a3b219fdcfe78c82dacf4	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	4561646186
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2022-09-30 18:14:08.179948	12	MARK_RAN	8:8acad7483e106416bcfa6f3b824a16cd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	4561646186
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2022-09-30 18:14:08.308609	13	EXECUTED	8:9b1266d17f4f87c78226f5055408fd5e	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	4561646186
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2022-09-30 18:14:08.369185	14	EXECUTED	8:d80ec4ab6dbfe573550ff72396c7e910	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.8.0	\N	\N	4561646186
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2022-09-30 18:14:08.373454	15	MARK_RAN	8:d86eb172171e7c20b9c849b584d147b2	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	4561646186
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2022-09-30 18:14:08.377369	16	MARK_RAN	8:5735f46f0fa60689deb0ecdc2a0dea22	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.8.0	\N	\N	4561646186
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2022-09-30 18:14:08.380126	17	EXECUTED	8:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.8.0	\N	\N	4561646186
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2022-09-30 18:14:08.507777	18	EXECUTED	8:5c1a8fd2014ac7fc43b90a700f117b23	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.8.0	\N	\N	4561646186
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2022-09-30 18:14:08.609214	19	EXECUTED	8:1f6c2c2dfc362aff4ed75b3f0ef6b331	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.8.0	\N	\N	4561646186
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2022-09-30 18:14:08.619138	20	EXECUTED	8:dee9246280915712591f83a127665107	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.8.0	\N	\N	4561646186
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-09-30 18:14:09.64846	45	EXECUTED	8:a164ae073c56ffdbc98a615493609a52	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.8.0	\N	\N	4561646186
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2022-09-30 18:14:08.623563	21	MARK_RAN	8:9eb2ee1fa8ad1c5e426421a6f8fdfa6a	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.8.0	\N	\N	4561646186
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2022-09-30 18:14:08.628182	22	MARK_RAN	8:dee9246280915712591f83a127665107	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.8.0	\N	\N	4561646186
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2022-09-30 18:14:08.671306	23	EXECUTED	8:d9fa18ffa355320395b86270680dd4fe	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.8.0	\N	\N	4561646186
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2022-09-30 18:14:08.680264	24	EXECUTED	8:90cff506fedb06141ffc1c71c4a1214c	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.8.0	\N	\N	4561646186
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2022-09-30 18:14:08.683255	25	MARK_RAN	8:11a788aed4961d6d29c427c063af828c	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.8.0	\N	\N	4561646186
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2022-09-30 18:14:08.733245	26	EXECUTED	8:a4218e51e1faf380518cce2af5d39b43	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.8.0	\N	\N	4561646186
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2022-09-30 18:14:08.845953	27	EXECUTED	8:d9e9a1bfaa644da9952456050f07bbdc	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.8.0	\N	\N	4561646186
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2022-09-30 18:14:08.85226	28	EXECUTED	8:d1bf991a6163c0acbfe664b615314505	update tableName=RESOURCE_SERVER_POLICY		\N	4.8.0	\N	\N	4561646186
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2022-09-30 18:14:08.945755	29	EXECUTED	8:88a743a1e87ec5e30bf603da68058a8c	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.8.0	\N	\N	4561646186
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2022-09-30 18:14:08.972664	30	EXECUTED	8:c5517863c875d325dea463d00ec26d7a	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.8.0	\N	\N	4561646186
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2022-09-30 18:14:09.001075	31	EXECUTED	8:ada8b4833b74a498f376d7136bc7d327	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.8.0	\N	\N	4561646186
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2022-09-30 18:14:09.009708	32	EXECUTED	8:b9b73c8ea7299457f99fcbb825c263ba	customChange		\N	4.8.0	\N	\N	4561646186
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2022-09-30 18:14:09.019328	33	EXECUTED	8:07724333e625ccfcfc5adc63d57314f3	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	4561646186
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2022-09-30 18:14:09.022775	34	MARK_RAN	8:8b6fd445958882efe55deb26fc541a7b	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.8.0	\N	\N	4561646186
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2022-09-30 18:14:09.070755	35	EXECUTED	8:29b29cfebfd12600897680147277a9d7	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.8.0	\N	\N	4561646186
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2022-09-30 18:14:09.099398	36	EXECUTED	8:73ad77ca8fd0410c7f9f15a471fa52bc	addColumn tableName=REALM		\N	4.8.0	\N	\N	4561646186
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2022-09-30 18:14:09.116456	37	EXECUTED	8:64f27a6fdcad57f6f9153210f2ec1bdb	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	4561646186
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2022-09-30 18:14:09.142362	38	EXECUTED	8:27180251182e6c31846c2ddab4bc5781	addColumn tableName=FED_USER_CONSENT		\N	4.8.0	\N	\N	4561646186
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2022-09-30 18:14:09.173594	39	EXECUTED	8:d56f201bfcfa7a1413eb3e9bc02978f9	addColumn tableName=IDENTITY_PROVIDER		\N	4.8.0	\N	\N	4561646186
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2022-09-30 18:14:09.182195	40	MARK_RAN	8:91f5522bf6afdc2077dfab57fbd3455c	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.8.0	\N	\N	4561646186
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2022-09-30 18:14:09.193864	41	MARK_RAN	8:0f01b554f256c22caeb7d8aee3a1cdc8	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.8.0	\N	\N	4561646186
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2022-09-30 18:14:09.231458	42	EXECUTED	8:ab91cf9cee415867ade0e2df9651a947	customChange		\N	4.8.0	\N	\N	4561646186
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2022-09-30 18:14:09.615595	43	EXECUTED	8:ceac9b1889e97d602caf373eadb0d4b7	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.8.0	\N	\N	4561646186
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2022-09-30 18:14:09.638681	44	EXECUTED	8:84b986e628fe8f7fd8fd3c275c5259f2	addColumn tableName=USER_ENTITY		\N	4.8.0	\N	\N	4561646186
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-09-30 18:14:09.655699	46	EXECUTED	8:70a2b4f1f4bd4dbf487114bdb1810e64	customChange		\N	4.8.0	\N	\N	4561646186
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-09-30 18:14:09.659459	47	MARK_RAN	8:7be68b71d2f5b94b8df2e824f2860fa2	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.8.0	\N	\N	4561646186
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-09-30 18:14:09.738452	48	EXECUTED	8:bab7c631093c3861d6cf6144cd944982	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.8.0	\N	\N	4561646186
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-09-30 18:14:09.7632	49	EXECUTED	8:fa809ac11877d74d76fe40869916daad	addColumn tableName=REALM		\N	4.8.0	\N	\N	4561646186
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2022-09-30 18:14:09.831037	50	EXECUTED	8:fac23540a40208f5f5e326f6ceb4d291	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.8.0	\N	\N	4561646186
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2022-09-30 18:14:09.878994	51	EXECUTED	8:2612d1b8a97e2b5588c346e817307593	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.8.0	\N	\N	4561646186
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2022-09-30 18:14:09.88535	52	EXECUTED	8:9842f155c5db2206c88bcb5d1046e941	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	4561646186
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2022-09-30 18:14:09.889685	53	EXECUTED	8:2e12e06e45498406db72d5b3da5bbc76	update tableName=REALM		\N	4.8.0	\N	\N	4561646186
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2022-09-30 18:14:09.895379	54	EXECUTED	8:33560e7c7989250c40da3abdabdc75a4	update tableName=CLIENT		\N	4.8.0	\N	\N	4561646186
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2022-09-30 18:14:09.90664	55	EXECUTED	8:87a8d8542046817a9107c7eb9cbad1cd	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.8.0	\N	\N	4561646186
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2022-09-30 18:14:09.923457	56	EXECUTED	8:3ea08490a70215ed0088c273d776311e	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.8.0	\N	\N	4561646186
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2022-09-30 18:14:09.979166	57	EXECUTED	8:2d56697c8723d4592ab608ce14b6ed68	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.8.0	\N	\N	4561646186
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2022-09-30 18:14:10.166886	58	EXECUTED	8:3e423e249f6068ea2bbe48bf907f9d86	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.8.0	\N	\N	4561646186
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2022-09-30 18:14:10.238738	59	EXECUTED	8:15cabee5e5df0ff099510a0fc03e4103	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.8.0	\N	\N	4561646186
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2022-09-30 18:14:10.251525	60	EXECUTED	8:4b80200af916ac54d2ffbfc47918ab0e	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.8.0	\N	\N	4561646186
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2022-09-30 18:14:10.267072	61	EXECUTED	8:66564cd5e168045d52252c5027485bbb	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.8.0	\N	\N	4561646186
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2022-09-30 18:14:10.277421	62	EXECUTED	8:1c7064fafb030222be2bd16ccf690f6f	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.8.0	\N	\N	4561646186
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2022-09-30 18:14:10.299875	63	EXECUTED	8:2de18a0dce10cdda5c7e65c9b719b6e5	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.8.0	\N	\N	4561646186
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2022-09-30 18:14:10.321549	64	EXECUTED	8:03e413dd182dcbd5c57e41c34d0ef682	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.8.0	\N	\N	4561646186
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2022-09-30 18:14:10.344542	65	EXECUTED	8:d27b42bb2571c18fbe3fe4e4fb7582a7	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.8.0	\N	\N	4561646186
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2022-09-30 18:14:10.427021	66	EXECUTED	8:698baf84d9fd0027e9192717c2154fb8	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.8.0	\N	\N	4561646186
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2022-09-30 18:14:10.445443	67	EXECUTED	8:ced8822edf0f75ef26eb51582f9a821a	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.8.0	\N	\N	4561646186
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2022-09-30 18:14:10.482652	68	EXECUTED	8:f0abba004cf429e8afc43056df06487d	addColumn tableName=REALM		\N	4.8.0	\N	\N	4561646186
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2022-09-30 18:14:10.507553	69	EXECUTED	8:6662f8b0b611caa359fcf13bf63b4e24	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.8.0	\N	\N	4561646186
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2022-09-30 18:14:10.899341	105	EXECUTED	8:5e06b1d75f5d17685485e610c2851b17	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.8.0	\N	\N	4561646186
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2022-09-30 18:14:10.517132	70	EXECUTED	8:9e6b8009560f684250bdbdf97670d39e	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.8.0	\N	\N	4561646186
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2022-09-30 18:14:10.527422	71	EXECUTED	8:4223f561f3b8dc655846562b57bb502e	addColumn tableName=RESOURCE_SERVER		\N	4.8.0	\N	\N	4561646186
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-09-30 18:14:10.539879	72	EXECUTED	8:215a31c398b363ce383a2b301202f29e	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	4561646186
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-09-30 18:14:10.550681	73	EXECUTED	8:83f7a671792ca98b3cbd3a1a34862d3d	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	4561646186
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-09-30 18:14:10.554495	74	MARK_RAN	8:f58ad148698cf30707a6efbdf8061aa7	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	4561646186
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-09-30 18:14:10.587085	75	EXECUTED	8:79e4fd6c6442980e58d52ffc3ee7b19c	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.8.0	\N	\N	4561646186
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-09-30 18:14:10.602332	76	EXECUTED	8:87af6a1e6d241ca4b15801d1f86a297d	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.8.0	\N	\N	4561646186
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2022-09-30 18:14:10.621166	77	EXECUTED	8:b44f8d9b7b6ea455305a6d72a200ed15	addColumn tableName=CLIENT		\N	4.8.0	\N	\N	4561646186
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2022-09-30 18:14:10.624424	78	MARK_RAN	8:2d8ed5aaaeffd0cb004c046b4a903ac5	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.8.0	\N	\N	4561646186
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2022-09-30 18:14:10.654381	79	EXECUTED	8:e290c01fcbc275326c511633f6e2acde	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.8.0	\N	\N	4561646186
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2022-09-30 18:14:10.657449	80	MARK_RAN	8:c9db8784c33cea210872ac2d805439f8	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.8.0	\N	\N	4561646186
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-09-30 18:14:10.667217	81	EXECUTED	8:95b676ce8fc546a1fcfb4c92fae4add5	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.8.0	\N	\N	4561646186
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-09-30 18:14:10.670265	82	MARK_RAN	8:38a6b2a41f5651018b1aca93a41401e5	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	4561646186
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-09-30 18:14:10.677973	83	EXECUTED	8:3fb99bcad86a0229783123ac52f7609c	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	4561646186
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-09-30 18:14:10.683265	84	MARK_RAN	8:64f27a6fdcad57f6f9153210f2ec1bdb	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	4561646186
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-09-30 18:14:10.69377	85	EXECUTED	8:ab4f863f39adafd4c862f7ec01890abc	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.8.0	\N	\N	4561646186
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2022-09-30 18:14:10.70323	86	EXECUTED	8:13c419a0eb336e91ee3a3bf8fda6e2a7	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.8.0	\N	\N	4561646186
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2022-09-30 18:14:10.716897	87	EXECUTED	8:e3fb1e698e0471487f51af1ed80fe3ac	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.8.0	\N	\N	4561646186
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2022-09-30 18:14:10.731993	88	EXECUTED	8:babadb686aab7b56562817e60bf0abd0	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.8.0	\N	\N	4561646186
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-09-30 18:14:10.743581	89	EXECUTED	8:72d03345fda8e2f17093d08801947773	addColumn tableName=REALM; customChange		\N	4.8.0	\N	\N	4561646186
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-09-30 18:14:10.753866	90	EXECUTED	8:61c9233951bd96ffecd9ba75f7d978a4	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.8.0	\N	\N	4561646186
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-09-30 18:14:10.766651	91	EXECUTED	8:ea82e6ad945cec250af6372767b25525	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	4561646186
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-09-30 18:14:10.780936	92	EXECUTED	8:d3f4a33f41d960ddacd7e2ef30d126b3	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.8.0	\N	\N	4561646186
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-09-30 18:14:10.789114	93	MARK_RAN	8:1284a27fbd049d65831cb6fc07c8a783	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.8.0	\N	\N	4561646186
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2022-09-30 18:14:10.91539	107	EXECUTED	8:af510cd1bb2ab6339c45372f3e491696	customChange		\N	4.8.0	\N	\N	4561646186
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-09-30 18:14:10.804409	94	EXECUTED	8:9d11b619db2ae27c25853b8a37cd0dea	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.8.0	\N	\N	4561646186
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-09-30 18:14:10.808463	95	MARK_RAN	8:3002bb3997451bb9e8bac5c5cd8d6327	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.8.0	\N	\N	4561646186
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-09-30 18:14:10.817044	96	EXECUTED	8:dfbee0d6237a23ef4ccbb7a4e063c163	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.8.0	\N	\N	4561646186
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-09-30 18:14:10.833566	97	EXECUTED	8:75f3e372df18d38c62734eebb986b960	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	4561646186
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-09-30 18:14:10.836994	98	MARK_RAN	8:7fee73eddf84a6035691512c85637eef	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	4561646186
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-09-30 18:14:10.850365	99	MARK_RAN	8:7a11134ab12820f999fbf3bb13c3adc8	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	4561646186
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-09-30 18:14:10.860346	100	EXECUTED	8:c0f6eaac1f3be773ffe54cb5b8482b70	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	4561646186
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-09-30 18:14:10.86334	101	MARK_RAN	8:18186f0008b86e0f0f49b0c4d0e842ac	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	4561646186
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-09-30 18:14:10.872975	102	EXECUTED	8:09c2780bcb23b310a7019d217dc7b433	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.8.0	\N	\N	4561646186
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-09-30 18:14:10.879808	103	EXECUTED	8:276a44955eab693c970a42880197fff2	customChange		\N	4.8.0	\N	\N	4561646186
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2022-09-30 18:14:10.889898	104	EXECUTED	8:ba8ee3b694d043f2bfc1a1079d0760d7	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.8.0	\N	\N	4561646186
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2022-09-30 18:14:10.899341	105	EXECUTED	8:5e06b1d75f5d17685485e610c2851b17	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.8.0	\N	\N	4561646186
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2022-09-30 18:14:10.908162	106	EXECUTED	8:4b80546c1dc550ac552ee7b24a4ab7c0	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.8.0	\N	\N	4561646186
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2022-09-30 18:14:10.91539	107	EXECUTED	8:af510cd1bb2ab6339c45372f3e491696	customChange		\N	4.8.0	\N	\N	4561646186
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2022-09-30 18:14:07.00936	1	EXECUTED	8:bda77d94bf90182a1e30c24f1c155ec7	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.8.0	\N	\N	4561646186
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2022-09-30 18:14:07.020872	2	MARK_RAN	8:1ecb330f30986693d1cba9ab579fa219	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.8.0	\N	\N	4561646186
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2022-09-30 18:14:07.099686	3	EXECUTED	8:cb7ace19bc6d959f305605d255d4c843	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.8.0	\N	\N	4561646186
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2022-09-30 18:14:07.109846	4	EXECUTED	8:80230013e961310e6872e871be424a63	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.8.0	\N	\N	4561646186
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2022-09-30 18:14:07.647219	5	EXECUTED	8:67f4c20929126adc0c8e9bf48279d244	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.8.0	\N	\N	4561646186
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2022-09-30 18:14:07.67001	6	MARK_RAN	8:7311018b0b8179ce14628ab412bb6783	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.8.0	\N	\N	4561646186
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2022-09-30 18:14:07.846461	7	EXECUTED	8:037ba1216c3640f8785ee6b8e7c8e3c1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.8.0	\N	\N	4561646186
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2022-09-30 18:14:07.8509	8	MARK_RAN	8:7fe6ffe4af4df289b3157de32c624263	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.8.0	\N	\N	4561646186
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2022-09-30 18:14:07.861103	9	EXECUTED	8:9c136bc3187083a98745c7d03bc8a303	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.8.0	\N	\N	4561646186
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2022-09-30 18:14:08.043913	10	EXECUTED	8:b5f09474dca81fb56a97cf5b6553d331	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.8.0	\N	\N	4561646186
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2022-09-30 18:14:08.17495	11	EXECUTED	8:ca924f31bd2a3b219fdcfe78c82dacf4	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	4561646186
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2022-09-30 18:14:08.179948	12	MARK_RAN	8:8acad7483e106416bcfa6f3b824a16cd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	4561646186
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2022-09-30 18:14:08.308609	13	EXECUTED	8:9b1266d17f4f87c78226f5055408fd5e	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	4561646186
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2022-09-30 18:14:08.369185	14	EXECUTED	8:d80ec4ab6dbfe573550ff72396c7e910	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.8.0	\N	\N	4561646186
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2022-09-30 18:14:08.373454	15	MARK_RAN	8:d86eb172171e7c20b9c849b584d147b2	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	4561646186
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2022-09-30 18:14:08.377369	16	MARK_RAN	8:5735f46f0fa60689deb0ecdc2a0dea22	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.8.0	\N	\N	4561646186
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2022-09-30 18:14:08.380126	17	EXECUTED	8:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.8.0	\N	\N	4561646186
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2022-09-30 18:14:08.507777	18	EXECUTED	8:5c1a8fd2014ac7fc43b90a700f117b23	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.8.0	\N	\N	4561646186
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2022-09-30 18:14:08.609214	19	EXECUTED	8:1f6c2c2dfc362aff4ed75b3f0ef6b331	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.8.0	\N	\N	4561646186
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2022-09-30 18:14:08.619138	20	EXECUTED	8:dee9246280915712591f83a127665107	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.8.0	\N	\N	4561646186
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-09-30 18:14:09.64846	45	EXECUTED	8:a164ae073c56ffdbc98a615493609a52	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.8.0	\N	\N	4561646186
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2022-09-30 18:14:08.623563	21	MARK_RAN	8:9eb2ee1fa8ad1c5e426421a6f8fdfa6a	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.8.0	\N	\N	4561646186
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2022-09-30 18:14:08.628182	22	MARK_RAN	8:dee9246280915712591f83a127665107	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.8.0	\N	\N	4561646186
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2022-09-30 18:14:08.671306	23	EXECUTED	8:d9fa18ffa355320395b86270680dd4fe	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.8.0	\N	\N	4561646186
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2022-09-30 18:14:08.680264	24	EXECUTED	8:90cff506fedb06141ffc1c71c4a1214c	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.8.0	\N	\N	4561646186
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2022-09-30 18:14:08.683255	25	MARK_RAN	8:11a788aed4961d6d29c427c063af828c	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.8.0	\N	\N	4561646186
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2022-09-30 18:14:08.733245	26	EXECUTED	8:a4218e51e1faf380518cce2af5d39b43	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.8.0	\N	\N	4561646186
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2022-09-30 18:14:08.845953	27	EXECUTED	8:d9e9a1bfaa644da9952456050f07bbdc	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.8.0	\N	\N	4561646186
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2022-09-30 18:14:08.85226	28	EXECUTED	8:d1bf991a6163c0acbfe664b615314505	update tableName=RESOURCE_SERVER_POLICY		\N	4.8.0	\N	\N	4561646186
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2022-09-30 18:14:08.945755	29	EXECUTED	8:88a743a1e87ec5e30bf603da68058a8c	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.8.0	\N	\N	4561646186
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2022-09-30 18:14:10.908162	106	EXECUTED	8:4b80546c1dc550ac552ee7b24a4ab7c0	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.8.0	\N	\N	4561646186
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2022-09-30 18:14:08.972664	30	EXECUTED	8:c5517863c875d325dea463d00ec26d7a	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.8.0	\N	\N	4561646186
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2022-09-30 18:14:09.001075	31	EXECUTED	8:ada8b4833b74a498f376d7136bc7d327	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.8.0	\N	\N	4561646186
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2022-09-30 18:14:09.009708	32	EXECUTED	8:b9b73c8ea7299457f99fcbb825c263ba	customChange		\N	4.8.0	\N	\N	4561646186
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2022-09-30 18:14:09.019328	33	EXECUTED	8:07724333e625ccfcfc5adc63d57314f3	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	4561646186
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2022-09-30 18:14:09.022775	34	MARK_RAN	8:8b6fd445958882efe55deb26fc541a7b	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.8.0	\N	\N	4561646186
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2022-09-30 18:14:09.070755	35	EXECUTED	8:29b29cfebfd12600897680147277a9d7	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.8.0	\N	\N	4561646186
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2022-09-30 18:14:09.099398	36	EXECUTED	8:73ad77ca8fd0410c7f9f15a471fa52bc	addColumn tableName=REALM		\N	4.8.0	\N	\N	4561646186
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2022-09-30 18:14:09.116456	37	EXECUTED	8:64f27a6fdcad57f6f9153210f2ec1bdb	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	4561646186
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2022-09-30 18:14:09.142362	38	EXECUTED	8:27180251182e6c31846c2ddab4bc5781	addColumn tableName=FED_USER_CONSENT		\N	4.8.0	\N	\N	4561646186
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2022-09-30 18:14:09.173594	39	EXECUTED	8:d56f201bfcfa7a1413eb3e9bc02978f9	addColumn tableName=IDENTITY_PROVIDER		\N	4.8.0	\N	\N	4561646186
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2022-09-30 18:14:09.182195	40	MARK_RAN	8:91f5522bf6afdc2077dfab57fbd3455c	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.8.0	\N	\N	4561646186
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2022-09-30 18:14:09.193864	41	MARK_RAN	8:0f01b554f256c22caeb7d8aee3a1cdc8	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.8.0	\N	\N	4561646186
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2022-09-30 18:14:09.231458	42	EXECUTED	8:ab91cf9cee415867ade0e2df9651a947	customChange		\N	4.8.0	\N	\N	4561646186
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2022-09-30 18:14:09.615595	43	EXECUTED	8:ceac9b1889e97d602caf373eadb0d4b7	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.8.0	\N	\N	4561646186
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2022-09-30 18:14:09.638681	44	EXECUTED	8:84b986e628fe8f7fd8fd3c275c5259f2	addColumn tableName=USER_ENTITY		\N	4.8.0	\N	\N	4561646186
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-09-30 18:14:09.655699	46	EXECUTED	8:70a2b4f1f4bd4dbf487114bdb1810e64	customChange		\N	4.8.0	\N	\N	4561646186
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-09-30 18:14:09.659459	47	MARK_RAN	8:7be68b71d2f5b94b8df2e824f2860fa2	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.8.0	\N	\N	4561646186
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-09-30 18:14:09.738452	48	EXECUTED	8:bab7c631093c3861d6cf6144cd944982	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.8.0	\N	\N	4561646186
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-09-30 18:14:09.7632	49	EXECUTED	8:fa809ac11877d74d76fe40869916daad	addColumn tableName=REALM		\N	4.8.0	\N	\N	4561646186
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2022-09-30 18:14:09.831037	50	EXECUTED	8:fac23540a40208f5f5e326f6ceb4d291	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.8.0	\N	\N	4561646186
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2022-09-30 18:14:09.878994	51	EXECUTED	8:2612d1b8a97e2b5588c346e817307593	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.8.0	\N	\N	4561646186
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2022-09-30 18:14:09.88535	52	EXECUTED	8:9842f155c5db2206c88bcb5d1046e941	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	4561646186
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2022-09-30 18:14:09.889685	53	EXECUTED	8:2e12e06e45498406db72d5b3da5bbc76	update tableName=REALM		\N	4.8.0	\N	\N	4561646186
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2022-09-30 18:14:09.895379	54	EXECUTED	8:33560e7c7989250c40da3abdabdc75a4	update tableName=CLIENT		\N	4.8.0	\N	\N	4561646186
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2022-09-30 18:14:09.90664	55	EXECUTED	8:87a8d8542046817a9107c7eb9cbad1cd	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.8.0	\N	\N	4561646186
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2022-09-30 18:14:09.923457	56	EXECUTED	8:3ea08490a70215ed0088c273d776311e	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.8.0	\N	\N	4561646186
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2022-09-30 18:14:09.979166	57	EXECUTED	8:2d56697c8723d4592ab608ce14b6ed68	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.8.0	\N	\N	4561646186
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2022-09-30 18:14:10.166886	58	EXECUTED	8:3e423e249f6068ea2bbe48bf907f9d86	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.8.0	\N	\N	4561646186
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2022-09-30 18:14:10.238738	59	EXECUTED	8:15cabee5e5df0ff099510a0fc03e4103	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.8.0	\N	\N	4561646186
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2022-09-30 18:14:10.251525	60	EXECUTED	8:4b80200af916ac54d2ffbfc47918ab0e	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.8.0	\N	\N	4561646186
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2022-09-30 18:14:10.267072	61	EXECUTED	8:66564cd5e168045d52252c5027485bbb	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.8.0	\N	\N	4561646186
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2022-09-30 18:14:10.277421	62	EXECUTED	8:1c7064fafb030222be2bd16ccf690f6f	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.8.0	\N	\N	4561646186
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2022-09-30 18:14:10.299875	63	EXECUTED	8:2de18a0dce10cdda5c7e65c9b719b6e5	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.8.0	\N	\N	4561646186
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2022-09-30 18:14:10.321549	64	EXECUTED	8:03e413dd182dcbd5c57e41c34d0ef682	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.8.0	\N	\N	4561646186
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2022-09-30 18:14:10.344542	65	EXECUTED	8:d27b42bb2571c18fbe3fe4e4fb7582a7	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.8.0	\N	\N	4561646186
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2022-09-30 18:14:10.427021	66	EXECUTED	8:698baf84d9fd0027e9192717c2154fb8	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.8.0	\N	\N	4561646186
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2022-09-30 18:14:10.445443	67	EXECUTED	8:ced8822edf0f75ef26eb51582f9a821a	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.8.0	\N	\N	4561646186
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2022-09-30 18:14:10.482652	68	EXECUTED	8:f0abba004cf429e8afc43056df06487d	addColumn tableName=REALM		\N	4.8.0	\N	\N	4561646186
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2022-09-30 18:14:10.507553	69	EXECUTED	8:6662f8b0b611caa359fcf13bf63b4e24	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.8.0	\N	\N	4561646186
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2022-09-30 18:14:10.517132	70	EXECUTED	8:9e6b8009560f684250bdbdf97670d39e	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.8.0	\N	\N	4561646186
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2022-09-30 18:14:10.527422	71	EXECUTED	8:4223f561f3b8dc655846562b57bb502e	addColumn tableName=RESOURCE_SERVER		\N	4.8.0	\N	\N	4561646186
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-09-30 18:14:10.539879	72	EXECUTED	8:215a31c398b363ce383a2b301202f29e	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	4561646186
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-09-30 18:14:10.550681	73	EXECUTED	8:83f7a671792ca98b3cbd3a1a34862d3d	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	4561646186
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-09-30 18:14:10.554495	74	MARK_RAN	8:f58ad148698cf30707a6efbdf8061aa7	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	4561646186
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-09-30 18:14:10.587085	75	EXECUTED	8:79e4fd6c6442980e58d52ffc3ee7b19c	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.8.0	\N	\N	4561646186
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-09-30 18:14:10.602332	76	EXECUTED	8:87af6a1e6d241ca4b15801d1f86a297d	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.8.0	\N	\N	4561646186
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2022-09-30 18:14:10.621166	77	EXECUTED	8:b44f8d9b7b6ea455305a6d72a200ed15	addColumn tableName=CLIENT		\N	4.8.0	\N	\N	4561646186
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2022-09-30 18:14:10.624424	78	MARK_RAN	8:2d8ed5aaaeffd0cb004c046b4a903ac5	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.8.0	\N	\N	4561646186
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2022-09-30 18:14:10.654381	79	EXECUTED	8:e290c01fcbc275326c511633f6e2acde	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.8.0	\N	\N	4561646186
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2022-09-30 18:14:10.657449	80	MARK_RAN	8:c9db8784c33cea210872ac2d805439f8	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.8.0	\N	\N	4561646186
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-09-30 18:14:10.667217	81	EXECUTED	8:95b676ce8fc546a1fcfb4c92fae4add5	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.8.0	\N	\N	4561646186
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-09-30 18:14:10.670265	82	MARK_RAN	8:38a6b2a41f5651018b1aca93a41401e5	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	4561646186
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-09-30 18:14:10.677973	83	EXECUTED	8:3fb99bcad86a0229783123ac52f7609c	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	4561646186
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-09-30 18:14:10.683265	84	MARK_RAN	8:64f27a6fdcad57f6f9153210f2ec1bdb	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	4561646186
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-09-30 18:14:10.69377	85	EXECUTED	8:ab4f863f39adafd4c862f7ec01890abc	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.8.0	\N	\N	4561646186
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2022-09-30 18:14:10.70323	86	EXECUTED	8:13c419a0eb336e91ee3a3bf8fda6e2a7	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.8.0	\N	\N	4561646186
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2022-09-30 18:14:10.716897	87	EXECUTED	8:e3fb1e698e0471487f51af1ed80fe3ac	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.8.0	\N	\N	4561646186
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2022-09-30 18:14:10.731993	88	EXECUTED	8:babadb686aab7b56562817e60bf0abd0	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.8.0	\N	\N	4561646186
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-09-30 18:14:10.743581	89	EXECUTED	8:72d03345fda8e2f17093d08801947773	addColumn tableName=REALM; customChange		\N	4.8.0	\N	\N	4561646186
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-09-30 18:14:10.753866	90	EXECUTED	8:61c9233951bd96ffecd9ba75f7d978a4	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.8.0	\N	\N	4561646186
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-09-30 18:14:10.766651	91	EXECUTED	8:ea82e6ad945cec250af6372767b25525	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	4561646186
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-09-30 18:14:10.780936	92	EXECUTED	8:d3f4a33f41d960ddacd7e2ef30d126b3	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.8.0	\N	\N	4561646186
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-09-30 18:14:10.789114	93	MARK_RAN	8:1284a27fbd049d65831cb6fc07c8a783	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.8.0	\N	\N	4561646186
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-09-30 18:14:10.804409	94	EXECUTED	8:9d11b619db2ae27c25853b8a37cd0dea	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.8.0	\N	\N	4561646186
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-09-30 18:14:10.808463	95	MARK_RAN	8:3002bb3997451bb9e8bac5c5cd8d6327	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.8.0	\N	\N	4561646186
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-09-30 18:14:10.817044	96	EXECUTED	8:dfbee0d6237a23ef4ccbb7a4e063c163	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.8.0	\N	\N	4561646186
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-09-30 18:14:10.833566	97	EXECUTED	8:75f3e372df18d38c62734eebb986b960	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	4561646186
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-09-30 18:14:10.836994	98	MARK_RAN	8:7fee73eddf84a6035691512c85637eef	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	4561646186
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-09-30 18:14:10.850365	99	MARK_RAN	8:7a11134ab12820f999fbf3bb13c3adc8	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	4561646186
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-09-30 18:14:10.860346	100	EXECUTED	8:c0f6eaac1f3be773ffe54cb5b8482b70	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	4561646186
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-09-30 18:14:10.86334	101	MARK_RAN	8:18186f0008b86e0f0f49b0c4d0e842ac	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	4561646186
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-09-30 18:14:10.872975	102	EXECUTED	8:09c2780bcb23b310a7019d217dc7b433	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.8.0	\N	\N	4561646186
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-09-30 18:14:10.879808	103	EXECUTED	8:276a44955eab693c970a42880197fff2	customChange		\N	4.8.0	\N	\N	4561646186
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2022-09-30 18:14:10.889898	104	EXECUTED	8:ba8ee3b694d043f2bfc1a1079d0760d7	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.8.0	\N	\N	4561646186
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2022-09-30 18:14:07.00936	1	EXECUTED	8:bda77d94bf90182a1e30c24f1c155ec7	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.8.0	\N	\N	4561646186
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2022-09-30 18:14:07.020872	2	MARK_RAN	8:1ecb330f30986693d1cba9ab579fa219	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.8.0	\N	\N	4561646186
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2022-09-30 18:14:07.099686	3	EXECUTED	8:cb7ace19bc6d959f305605d255d4c843	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.8.0	\N	\N	4561646186
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2022-09-30 18:14:07.109846	4	EXECUTED	8:80230013e961310e6872e871be424a63	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.8.0	\N	\N	4561646186
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2022-09-30 18:14:07.647219	5	EXECUTED	8:67f4c20929126adc0c8e9bf48279d244	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.8.0	\N	\N	4561646186
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2022-09-30 18:14:07.67001	6	MARK_RAN	8:7311018b0b8179ce14628ab412bb6783	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.8.0	\N	\N	4561646186
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2022-09-30 18:14:07.846461	7	EXECUTED	8:037ba1216c3640f8785ee6b8e7c8e3c1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.8.0	\N	\N	4561646186
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2022-09-30 18:14:07.8509	8	MARK_RAN	8:7fe6ffe4af4df289b3157de32c624263	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.8.0	\N	\N	4561646186
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2022-09-30 18:14:07.861103	9	EXECUTED	8:9c136bc3187083a98745c7d03bc8a303	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.8.0	\N	\N	4561646186
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2022-09-30 18:14:08.043913	10	EXECUTED	8:b5f09474dca81fb56a97cf5b6553d331	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.8.0	\N	\N	4561646186
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2022-09-30 18:14:08.17495	11	EXECUTED	8:ca924f31bd2a3b219fdcfe78c82dacf4	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	4561646186
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2022-09-30 18:14:08.179948	12	MARK_RAN	8:8acad7483e106416bcfa6f3b824a16cd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	4561646186
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2022-09-30 18:14:08.308609	13	EXECUTED	8:9b1266d17f4f87c78226f5055408fd5e	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	4561646186
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2022-09-30 18:14:08.369185	14	EXECUTED	8:d80ec4ab6dbfe573550ff72396c7e910	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.8.0	\N	\N	4561646186
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2022-09-30 18:14:08.373454	15	MARK_RAN	8:d86eb172171e7c20b9c849b584d147b2	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	4561646186
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2022-09-30 18:14:08.377369	16	MARK_RAN	8:5735f46f0fa60689deb0ecdc2a0dea22	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.8.0	\N	\N	4561646186
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2022-09-30 18:14:08.380126	17	EXECUTED	8:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.8.0	\N	\N	4561646186
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2022-09-30 18:14:08.507777	18	EXECUTED	8:5c1a8fd2014ac7fc43b90a700f117b23	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.8.0	\N	\N	4561646186
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2022-09-30 18:14:08.609214	19	EXECUTED	8:1f6c2c2dfc362aff4ed75b3f0ef6b331	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.8.0	\N	\N	4561646186
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2022-09-30 18:14:08.619138	20	EXECUTED	8:dee9246280915712591f83a127665107	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.8.0	\N	\N	4561646186
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-09-30 18:14:09.64846	45	EXECUTED	8:a164ae073c56ffdbc98a615493609a52	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.8.0	\N	\N	4561646186
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2022-09-30 18:14:08.623563	21	MARK_RAN	8:9eb2ee1fa8ad1c5e426421a6f8fdfa6a	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.8.0	\N	\N	4561646186
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2022-09-30 18:14:08.628182	22	MARK_RAN	8:dee9246280915712591f83a127665107	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.8.0	\N	\N	4561646186
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2022-09-30 18:14:08.671306	23	EXECUTED	8:d9fa18ffa355320395b86270680dd4fe	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.8.0	\N	\N	4561646186
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2022-09-30 18:14:08.680264	24	EXECUTED	8:90cff506fedb06141ffc1c71c4a1214c	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.8.0	\N	\N	4561646186
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2022-09-30 18:14:08.683255	25	MARK_RAN	8:11a788aed4961d6d29c427c063af828c	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.8.0	\N	\N	4561646186
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2022-09-30 18:14:08.733245	26	EXECUTED	8:a4218e51e1faf380518cce2af5d39b43	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.8.0	\N	\N	4561646186
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2022-09-30 18:14:08.845953	27	EXECUTED	8:d9e9a1bfaa644da9952456050f07bbdc	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.8.0	\N	\N	4561646186
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2022-09-30 18:14:08.85226	28	EXECUTED	8:d1bf991a6163c0acbfe664b615314505	update tableName=RESOURCE_SERVER_POLICY		\N	4.8.0	\N	\N	4561646186
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2022-09-30 18:14:08.945755	29	EXECUTED	8:88a743a1e87ec5e30bf603da68058a8c	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.8.0	\N	\N	4561646186
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2022-09-30 18:14:08.972664	30	EXECUTED	8:c5517863c875d325dea463d00ec26d7a	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.8.0	\N	\N	4561646186
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2022-09-30 18:14:09.001075	31	EXECUTED	8:ada8b4833b74a498f376d7136bc7d327	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.8.0	\N	\N	4561646186
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2022-09-30 18:14:09.009708	32	EXECUTED	8:b9b73c8ea7299457f99fcbb825c263ba	customChange		\N	4.8.0	\N	\N	4561646186
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2022-09-30 18:14:09.019328	33	EXECUTED	8:07724333e625ccfcfc5adc63d57314f3	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	4561646186
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2022-09-30 18:14:09.022775	34	MARK_RAN	8:8b6fd445958882efe55deb26fc541a7b	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.8.0	\N	\N	4561646186
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2022-09-30 18:14:09.070755	35	EXECUTED	8:29b29cfebfd12600897680147277a9d7	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.8.0	\N	\N	4561646186
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2022-09-30 18:14:09.099398	36	EXECUTED	8:73ad77ca8fd0410c7f9f15a471fa52bc	addColumn tableName=REALM		\N	4.8.0	\N	\N	4561646186
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2022-09-30 18:14:09.116456	37	EXECUTED	8:64f27a6fdcad57f6f9153210f2ec1bdb	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	4561646186
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2022-09-30 18:14:09.142362	38	EXECUTED	8:27180251182e6c31846c2ddab4bc5781	addColumn tableName=FED_USER_CONSENT		\N	4.8.0	\N	\N	4561646186
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2022-09-30 18:14:09.173594	39	EXECUTED	8:d56f201bfcfa7a1413eb3e9bc02978f9	addColumn tableName=IDENTITY_PROVIDER		\N	4.8.0	\N	\N	4561646186
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2022-09-30 18:14:09.182195	40	MARK_RAN	8:91f5522bf6afdc2077dfab57fbd3455c	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.8.0	\N	\N	4561646186
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2022-09-30 18:14:09.193864	41	MARK_RAN	8:0f01b554f256c22caeb7d8aee3a1cdc8	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.8.0	\N	\N	4561646186
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2022-09-30 18:14:09.231458	42	EXECUTED	8:ab91cf9cee415867ade0e2df9651a947	customChange		\N	4.8.0	\N	\N	4561646186
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2022-09-30 18:14:09.615595	43	EXECUTED	8:ceac9b1889e97d602caf373eadb0d4b7	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.8.0	\N	\N	4561646186
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2022-09-30 18:14:09.638681	44	EXECUTED	8:84b986e628fe8f7fd8fd3c275c5259f2	addColumn tableName=USER_ENTITY		\N	4.8.0	\N	\N	4561646186
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-09-30 18:14:09.655699	46	EXECUTED	8:70a2b4f1f4bd4dbf487114bdb1810e64	customChange		\N	4.8.0	\N	\N	4561646186
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-09-30 18:14:09.659459	47	MARK_RAN	8:7be68b71d2f5b94b8df2e824f2860fa2	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.8.0	\N	\N	4561646186
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-09-30 18:14:09.738452	48	EXECUTED	8:bab7c631093c3861d6cf6144cd944982	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.8.0	\N	\N	4561646186
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-09-30 18:14:09.7632	49	EXECUTED	8:fa809ac11877d74d76fe40869916daad	addColumn tableName=REALM		\N	4.8.0	\N	\N	4561646186
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2022-09-30 18:14:09.831037	50	EXECUTED	8:fac23540a40208f5f5e326f6ceb4d291	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.8.0	\N	\N	4561646186
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2022-09-30 18:14:09.878994	51	EXECUTED	8:2612d1b8a97e2b5588c346e817307593	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.8.0	\N	\N	4561646186
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2022-09-30 18:14:09.88535	52	EXECUTED	8:9842f155c5db2206c88bcb5d1046e941	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	4561646186
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2022-09-30 18:14:09.889685	53	EXECUTED	8:2e12e06e45498406db72d5b3da5bbc76	update tableName=REALM		\N	4.8.0	\N	\N	4561646186
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2022-09-30 18:14:09.895379	54	EXECUTED	8:33560e7c7989250c40da3abdabdc75a4	update tableName=CLIENT		\N	4.8.0	\N	\N	4561646186
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2022-09-30 18:14:09.90664	55	EXECUTED	8:87a8d8542046817a9107c7eb9cbad1cd	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.8.0	\N	\N	4561646186
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2022-09-30 18:14:09.923457	56	EXECUTED	8:3ea08490a70215ed0088c273d776311e	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.8.0	\N	\N	4561646186
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2022-09-30 18:14:09.979166	57	EXECUTED	8:2d56697c8723d4592ab608ce14b6ed68	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.8.0	\N	\N	4561646186
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2022-09-30 18:14:10.166886	58	EXECUTED	8:3e423e249f6068ea2bbe48bf907f9d86	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.8.0	\N	\N	4561646186
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2022-09-30 18:14:10.238738	59	EXECUTED	8:15cabee5e5df0ff099510a0fc03e4103	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.8.0	\N	\N	4561646186
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2022-09-30 18:14:10.251525	60	EXECUTED	8:4b80200af916ac54d2ffbfc47918ab0e	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.8.0	\N	\N	4561646186
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2022-09-30 18:14:10.267072	61	EXECUTED	8:66564cd5e168045d52252c5027485bbb	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.8.0	\N	\N	4561646186
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2022-09-30 18:14:10.277421	62	EXECUTED	8:1c7064fafb030222be2bd16ccf690f6f	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.8.0	\N	\N	4561646186
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2022-09-30 18:14:10.299875	63	EXECUTED	8:2de18a0dce10cdda5c7e65c9b719b6e5	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.8.0	\N	\N	4561646186
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2022-09-30 18:14:10.321549	64	EXECUTED	8:03e413dd182dcbd5c57e41c34d0ef682	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.8.0	\N	\N	4561646186
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2022-09-30 18:14:10.344542	65	EXECUTED	8:d27b42bb2571c18fbe3fe4e4fb7582a7	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.8.0	\N	\N	4561646186
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2022-09-30 18:14:10.427021	66	EXECUTED	8:698baf84d9fd0027e9192717c2154fb8	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.8.0	\N	\N	4561646186
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2022-09-30 18:14:10.445443	67	EXECUTED	8:ced8822edf0f75ef26eb51582f9a821a	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.8.0	\N	\N	4561646186
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2022-09-30 18:14:10.482652	68	EXECUTED	8:f0abba004cf429e8afc43056df06487d	addColumn tableName=REALM		\N	4.8.0	\N	\N	4561646186
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2022-09-30 18:14:10.507553	69	EXECUTED	8:6662f8b0b611caa359fcf13bf63b4e24	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.8.0	\N	\N	4561646186
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2022-09-30 18:14:10.899341	105	EXECUTED	8:5e06b1d75f5d17685485e610c2851b17	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.8.0	\N	\N	4561646186
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2022-09-30 18:14:10.517132	70	EXECUTED	8:9e6b8009560f684250bdbdf97670d39e	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.8.0	\N	\N	4561646186
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2022-09-30 18:14:10.527422	71	EXECUTED	8:4223f561f3b8dc655846562b57bb502e	addColumn tableName=RESOURCE_SERVER		\N	4.8.0	\N	\N	4561646186
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-09-30 18:14:10.539879	72	EXECUTED	8:215a31c398b363ce383a2b301202f29e	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	4561646186
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-09-30 18:14:10.550681	73	EXECUTED	8:83f7a671792ca98b3cbd3a1a34862d3d	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	4561646186
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-09-30 18:14:10.554495	74	MARK_RAN	8:f58ad148698cf30707a6efbdf8061aa7	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	4561646186
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-09-30 18:14:10.587085	75	EXECUTED	8:79e4fd6c6442980e58d52ffc3ee7b19c	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.8.0	\N	\N	4561646186
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-09-30 18:14:10.602332	76	EXECUTED	8:87af6a1e6d241ca4b15801d1f86a297d	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.8.0	\N	\N	4561646186
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2022-09-30 18:14:10.621166	77	EXECUTED	8:b44f8d9b7b6ea455305a6d72a200ed15	addColumn tableName=CLIENT		\N	4.8.0	\N	\N	4561646186
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2022-09-30 18:14:10.624424	78	MARK_RAN	8:2d8ed5aaaeffd0cb004c046b4a903ac5	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.8.0	\N	\N	4561646186
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2022-09-30 18:14:10.654381	79	EXECUTED	8:e290c01fcbc275326c511633f6e2acde	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.8.0	\N	\N	4561646186
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2022-09-30 18:14:10.657449	80	MARK_RAN	8:c9db8784c33cea210872ac2d805439f8	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.8.0	\N	\N	4561646186
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-09-30 18:14:10.667217	81	EXECUTED	8:95b676ce8fc546a1fcfb4c92fae4add5	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.8.0	\N	\N	4561646186
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-09-30 18:14:10.670265	82	MARK_RAN	8:38a6b2a41f5651018b1aca93a41401e5	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	4561646186
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-09-30 18:14:10.677973	83	EXECUTED	8:3fb99bcad86a0229783123ac52f7609c	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	4561646186
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-09-30 18:14:10.683265	84	MARK_RAN	8:64f27a6fdcad57f6f9153210f2ec1bdb	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	4561646186
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-09-30 18:14:10.69377	85	EXECUTED	8:ab4f863f39adafd4c862f7ec01890abc	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.8.0	\N	\N	4561646186
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2022-09-30 18:14:10.70323	86	EXECUTED	8:13c419a0eb336e91ee3a3bf8fda6e2a7	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.8.0	\N	\N	4561646186
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2022-09-30 18:14:10.716897	87	EXECUTED	8:e3fb1e698e0471487f51af1ed80fe3ac	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.8.0	\N	\N	4561646186
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2022-09-30 18:14:10.731993	88	EXECUTED	8:babadb686aab7b56562817e60bf0abd0	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.8.0	\N	\N	4561646186
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-09-30 18:14:10.743581	89	EXECUTED	8:72d03345fda8e2f17093d08801947773	addColumn tableName=REALM; customChange		\N	4.8.0	\N	\N	4561646186
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-09-30 18:14:10.753866	90	EXECUTED	8:61c9233951bd96ffecd9ba75f7d978a4	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.8.0	\N	\N	4561646186
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-09-30 18:14:10.766651	91	EXECUTED	8:ea82e6ad945cec250af6372767b25525	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	4561646186
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-09-30 18:14:10.780936	92	EXECUTED	8:d3f4a33f41d960ddacd7e2ef30d126b3	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.8.0	\N	\N	4561646186
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-09-30 18:14:10.789114	93	MARK_RAN	8:1284a27fbd049d65831cb6fc07c8a783	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.8.0	\N	\N	4561646186
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2022-09-30 18:14:10.91539	107	EXECUTED	8:af510cd1bb2ab6339c45372f3e491696	customChange		\N	4.8.0	\N	\N	4561646186
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-09-30 18:14:10.804409	94	EXECUTED	8:9d11b619db2ae27c25853b8a37cd0dea	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.8.0	\N	\N	4561646186
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-09-30 18:14:10.808463	95	MARK_RAN	8:3002bb3997451bb9e8bac5c5cd8d6327	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.8.0	\N	\N	4561646186
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-09-30 18:14:10.817044	96	EXECUTED	8:dfbee0d6237a23ef4ccbb7a4e063c163	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.8.0	\N	\N	4561646186
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-09-30 18:14:10.833566	97	EXECUTED	8:75f3e372df18d38c62734eebb986b960	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	4561646186
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-09-30 18:14:10.836994	98	MARK_RAN	8:7fee73eddf84a6035691512c85637eef	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	4561646186
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-09-30 18:14:10.850365	99	MARK_RAN	8:7a11134ab12820f999fbf3bb13c3adc8	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	4561646186
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-09-30 18:14:10.860346	100	EXECUTED	8:c0f6eaac1f3be773ffe54cb5b8482b70	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	4561646186
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-09-30 18:14:10.86334	101	MARK_RAN	8:18186f0008b86e0f0f49b0c4d0e842ac	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	4561646186
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-09-30 18:14:10.872975	102	EXECUTED	8:09c2780bcb23b310a7019d217dc7b433	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.8.0	\N	\N	4561646186
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-09-30 18:14:10.879808	103	EXECUTED	8:276a44955eab693c970a42880197fff2	customChange		\N	4.8.0	\N	\N	4561646186
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2022-09-30 18:14:10.889898	104	EXECUTED	8:ba8ee3b694d043f2bfc1a1079d0760d7	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.8.0	\N	\N	4561646186
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2022-09-30 18:14:10.899341	105	EXECUTED	8:5e06b1d75f5d17685485e610c2851b17	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.8.0	\N	\N	4561646186
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2022-09-30 18:14:10.908162	106	EXECUTED	8:4b80546c1dc550ac552ee7b24a4ab7c0	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.8.0	\N	\N	4561646186
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2022-09-30 18:14:10.91539	107	EXECUTED	8:af510cd1bb2ab6339c45372f3e491696	customChange		\N	4.8.0	\N	\N	4561646186
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2022-09-30 18:14:07.00936	1	EXECUTED	8:bda77d94bf90182a1e30c24f1c155ec7	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.8.0	\N	\N	4561646186
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2022-09-30 18:14:07.020872	2	MARK_RAN	8:1ecb330f30986693d1cba9ab579fa219	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.8.0	\N	\N	4561646186
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2022-09-30 18:14:07.099686	3	EXECUTED	8:cb7ace19bc6d959f305605d255d4c843	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.8.0	\N	\N	4561646186
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2022-09-30 18:14:07.109846	4	EXECUTED	8:80230013e961310e6872e871be424a63	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.8.0	\N	\N	4561646186
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2022-09-30 18:14:07.647219	5	EXECUTED	8:67f4c20929126adc0c8e9bf48279d244	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.8.0	\N	\N	4561646186
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2022-09-30 18:14:07.67001	6	MARK_RAN	8:7311018b0b8179ce14628ab412bb6783	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.8.0	\N	\N	4561646186
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2022-09-30 18:14:07.846461	7	EXECUTED	8:037ba1216c3640f8785ee6b8e7c8e3c1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.8.0	\N	\N	4561646186
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2022-09-30 18:14:07.8509	8	MARK_RAN	8:7fe6ffe4af4df289b3157de32c624263	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.8.0	\N	\N	4561646186
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2022-09-30 18:14:07.861103	9	EXECUTED	8:9c136bc3187083a98745c7d03bc8a303	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.8.0	\N	\N	4561646186
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2022-09-30 18:14:08.043913	10	EXECUTED	8:b5f09474dca81fb56a97cf5b6553d331	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.8.0	\N	\N	4561646186
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2022-09-30 18:14:08.17495	11	EXECUTED	8:ca924f31bd2a3b219fdcfe78c82dacf4	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	4561646186
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2022-09-30 18:14:08.179948	12	MARK_RAN	8:8acad7483e106416bcfa6f3b824a16cd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	4561646186
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2022-09-30 18:14:08.308609	13	EXECUTED	8:9b1266d17f4f87c78226f5055408fd5e	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	4561646186
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2022-09-30 18:14:08.369185	14	EXECUTED	8:d80ec4ab6dbfe573550ff72396c7e910	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.8.0	\N	\N	4561646186
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2022-09-30 18:14:08.373454	15	MARK_RAN	8:d86eb172171e7c20b9c849b584d147b2	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	4561646186
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2022-09-30 18:14:08.377369	16	MARK_RAN	8:5735f46f0fa60689deb0ecdc2a0dea22	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.8.0	\N	\N	4561646186
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2022-09-30 18:14:08.380126	17	EXECUTED	8:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.8.0	\N	\N	4561646186
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2022-09-30 18:14:08.507777	18	EXECUTED	8:5c1a8fd2014ac7fc43b90a700f117b23	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.8.0	\N	\N	4561646186
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2022-09-30 18:14:08.609214	19	EXECUTED	8:1f6c2c2dfc362aff4ed75b3f0ef6b331	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.8.0	\N	\N	4561646186
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2022-09-30 18:14:08.619138	20	EXECUTED	8:dee9246280915712591f83a127665107	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.8.0	\N	\N	4561646186
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-09-30 18:14:09.64846	45	EXECUTED	8:a164ae073c56ffdbc98a615493609a52	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.8.0	\N	\N	4561646186
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2022-09-30 18:14:08.623563	21	MARK_RAN	8:9eb2ee1fa8ad1c5e426421a6f8fdfa6a	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.8.0	\N	\N	4561646186
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2022-09-30 18:14:08.628182	22	MARK_RAN	8:dee9246280915712591f83a127665107	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.8.0	\N	\N	4561646186
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2022-09-30 18:14:08.671306	23	EXECUTED	8:d9fa18ffa355320395b86270680dd4fe	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.8.0	\N	\N	4561646186
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2022-09-30 18:14:08.680264	24	EXECUTED	8:90cff506fedb06141ffc1c71c4a1214c	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.8.0	\N	\N	4561646186
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2022-09-30 18:14:08.683255	25	MARK_RAN	8:11a788aed4961d6d29c427c063af828c	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.8.0	\N	\N	4561646186
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2022-09-30 18:14:08.733245	26	EXECUTED	8:a4218e51e1faf380518cce2af5d39b43	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.8.0	\N	\N	4561646186
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2022-09-30 18:14:08.845953	27	EXECUTED	8:d9e9a1bfaa644da9952456050f07bbdc	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.8.0	\N	\N	4561646186
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2022-09-30 18:14:08.85226	28	EXECUTED	8:d1bf991a6163c0acbfe664b615314505	update tableName=RESOURCE_SERVER_POLICY		\N	4.8.0	\N	\N	4561646186
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2022-09-30 18:14:08.945755	29	EXECUTED	8:88a743a1e87ec5e30bf603da68058a8c	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.8.0	\N	\N	4561646186
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2022-09-30 18:14:10.908162	106	EXECUTED	8:4b80546c1dc550ac552ee7b24a4ab7c0	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.8.0	\N	\N	4561646186
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2022-09-30 18:14:08.972664	30	EXECUTED	8:c5517863c875d325dea463d00ec26d7a	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.8.0	\N	\N	4561646186
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2022-09-30 18:14:09.001075	31	EXECUTED	8:ada8b4833b74a498f376d7136bc7d327	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.8.0	\N	\N	4561646186
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2022-09-30 18:14:09.009708	32	EXECUTED	8:b9b73c8ea7299457f99fcbb825c263ba	customChange		\N	4.8.0	\N	\N	4561646186
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2022-09-30 18:14:09.019328	33	EXECUTED	8:07724333e625ccfcfc5adc63d57314f3	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	4561646186
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2022-09-30 18:14:09.022775	34	MARK_RAN	8:8b6fd445958882efe55deb26fc541a7b	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.8.0	\N	\N	4561646186
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2022-09-30 18:14:09.070755	35	EXECUTED	8:29b29cfebfd12600897680147277a9d7	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.8.0	\N	\N	4561646186
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2022-09-30 18:14:09.099398	36	EXECUTED	8:73ad77ca8fd0410c7f9f15a471fa52bc	addColumn tableName=REALM		\N	4.8.0	\N	\N	4561646186
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2022-09-30 18:14:09.116456	37	EXECUTED	8:64f27a6fdcad57f6f9153210f2ec1bdb	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	4561646186
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2022-09-30 18:14:09.142362	38	EXECUTED	8:27180251182e6c31846c2ddab4bc5781	addColumn tableName=FED_USER_CONSENT		\N	4.8.0	\N	\N	4561646186
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2022-09-30 18:14:09.173594	39	EXECUTED	8:d56f201bfcfa7a1413eb3e9bc02978f9	addColumn tableName=IDENTITY_PROVIDER		\N	4.8.0	\N	\N	4561646186
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2022-09-30 18:14:09.182195	40	MARK_RAN	8:91f5522bf6afdc2077dfab57fbd3455c	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.8.0	\N	\N	4561646186
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2022-09-30 18:14:09.193864	41	MARK_RAN	8:0f01b554f256c22caeb7d8aee3a1cdc8	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.8.0	\N	\N	4561646186
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2022-09-30 18:14:09.231458	42	EXECUTED	8:ab91cf9cee415867ade0e2df9651a947	customChange		\N	4.8.0	\N	\N	4561646186
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2022-09-30 18:14:09.615595	43	EXECUTED	8:ceac9b1889e97d602caf373eadb0d4b7	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.8.0	\N	\N	4561646186
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2022-09-30 18:14:09.638681	44	EXECUTED	8:84b986e628fe8f7fd8fd3c275c5259f2	addColumn tableName=USER_ENTITY		\N	4.8.0	\N	\N	4561646186
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-09-30 18:14:09.655699	46	EXECUTED	8:70a2b4f1f4bd4dbf487114bdb1810e64	customChange		\N	4.8.0	\N	\N	4561646186
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-09-30 18:14:09.659459	47	MARK_RAN	8:7be68b71d2f5b94b8df2e824f2860fa2	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.8.0	\N	\N	4561646186
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-09-30 18:14:09.738452	48	EXECUTED	8:bab7c631093c3861d6cf6144cd944982	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.8.0	\N	\N	4561646186
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-09-30 18:14:09.7632	49	EXECUTED	8:fa809ac11877d74d76fe40869916daad	addColumn tableName=REALM		\N	4.8.0	\N	\N	4561646186
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2022-09-30 18:14:09.831037	50	EXECUTED	8:fac23540a40208f5f5e326f6ceb4d291	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.8.0	\N	\N	4561646186
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2022-09-30 18:14:09.878994	51	EXECUTED	8:2612d1b8a97e2b5588c346e817307593	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.8.0	\N	\N	4561646186
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2022-09-30 18:14:09.88535	52	EXECUTED	8:9842f155c5db2206c88bcb5d1046e941	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	4561646186
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2022-09-30 18:14:09.889685	53	EXECUTED	8:2e12e06e45498406db72d5b3da5bbc76	update tableName=REALM		\N	4.8.0	\N	\N	4561646186
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2022-09-30 18:14:09.895379	54	EXECUTED	8:33560e7c7989250c40da3abdabdc75a4	update tableName=CLIENT		\N	4.8.0	\N	\N	4561646186
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2022-09-30 18:14:09.90664	55	EXECUTED	8:87a8d8542046817a9107c7eb9cbad1cd	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.8.0	\N	\N	4561646186
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2022-09-30 18:14:09.923457	56	EXECUTED	8:3ea08490a70215ed0088c273d776311e	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.8.0	\N	\N	4561646186
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2022-09-30 18:14:09.979166	57	EXECUTED	8:2d56697c8723d4592ab608ce14b6ed68	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.8.0	\N	\N	4561646186
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2022-09-30 18:14:10.166886	58	EXECUTED	8:3e423e249f6068ea2bbe48bf907f9d86	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.8.0	\N	\N	4561646186
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2022-09-30 18:14:10.238738	59	EXECUTED	8:15cabee5e5df0ff099510a0fc03e4103	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.8.0	\N	\N	4561646186
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2022-09-30 18:14:10.251525	60	EXECUTED	8:4b80200af916ac54d2ffbfc47918ab0e	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.8.0	\N	\N	4561646186
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2022-09-30 18:14:10.267072	61	EXECUTED	8:66564cd5e168045d52252c5027485bbb	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.8.0	\N	\N	4561646186
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2022-09-30 18:14:10.277421	62	EXECUTED	8:1c7064fafb030222be2bd16ccf690f6f	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.8.0	\N	\N	4561646186
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2022-09-30 18:14:10.299875	63	EXECUTED	8:2de18a0dce10cdda5c7e65c9b719b6e5	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.8.0	\N	\N	4561646186
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2022-09-30 18:14:10.321549	64	EXECUTED	8:03e413dd182dcbd5c57e41c34d0ef682	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.8.0	\N	\N	4561646186
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2022-09-30 18:14:10.344542	65	EXECUTED	8:d27b42bb2571c18fbe3fe4e4fb7582a7	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.8.0	\N	\N	4561646186
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2022-09-30 18:14:10.427021	66	EXECUTED	8:698baf84d9fd0027e9192717c2154fb8	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.8.0	\N	\N	4561646186
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2022-09-30 18:14:10.445443	67	EXECUTED	8:ced8822edf0f75ef26eb51582f9a821a	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.8.0	\N	\N	4561646186
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2022-09-30 18:14:10.482652	68	EXECUTED	8:f0abba004cf429e8afc43056df06487d	addColumn tableName=REALM		\N	4.8.0	\N	\N	4561646186
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2022-09-30 18:14:10.507553	69	EXECUTED	8:6662f8b0b611caa359fcf13bf63b4e24	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.8.0	\N	\N	4561646186
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2022-09-30 18:14:10.517132	70	EXECUTED	8:9e6b8009560f684250bdbdf97670d39e	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.8.0	\N	\N	4561646186
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2022-09-30 18:14:10.527422	71	EXECUTED	8:4223f561f3b8dc655846562b57bb502e	addColumn tableName=RESOURCE_SERVER		\N	4.8.0	\N	\N	4561646186
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-09-30 18:14:10.539879	72	EXECUTED	8:215a31c398b363ce383a2b301202f29e	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	4561646186
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-09-30 18:14:10.550681	73	EXECUTED	8:83f7a671792ca98b3cbd3a1a34862d3d	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	4561646186
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-09-30 18:14:10.554495	74	MARK_RAN	8:f58ad148698cf30707a6efbdf8061aa7	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	4561646186
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-09-30 18:14:10.587085	75	EXECUTED	8:79e4fd6c6442980e58d52ffc3ee7b19c	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.8.0	\N	\N	4561646186
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-09-30 18:14:10.602332	76	EXECUTED	8:87af6a1e6d241ca4b15801d1f86a297d	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.8.0	\N	\N	4561646186
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2022-09-30 18:14:10.621166	77	EXECUTED	8:b44f8d9b7b6ea455305a6d72a200ed15	addColumn tableName=CLIENT		\N	4.8.0	\N	\N	4561646186
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2022-09-30 18:14:10.624424	78	MARK_RAN	8:2d8ed5aaaeffd0cb004c046b4a903ac5	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.8.0	\N	\N	4561646186
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2022-09-30 18:14:10.654381	79	EXECUTED	8:e290c01fcbc275326c511633f6e2acde	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.8.0	\N	\N	4561646186
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2022-09-30 18:14:10.657449	80	MARK_RAN	8:c9db8784c33cea210872ac2d805439f8	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.8.0	\N	\N	4561646186
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-09-30 18:14:10.667217	81	EXECUTED	8:95b676ce8fc546a1fcfb4c92fae4add5	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.8.0	\N	\N	4561646186
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-09-30 18:14:10.670265	82	MARK_RAN	8:38a6b2a41f5651018b1aca93a41401e5	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	4561646186
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-09-30 18:14:10.677973	83	EXECUTED	8:3fb99bcad86a0229783123ac52f7609c	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	4561646186
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-09-30 18:14:10.683265	84	MARK_RAN	8:64f27a6fdcad57f6f9153210f2ec1bdb	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	4561646186
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-09-30 18:14:10.69377	85	EXECUTED	8:ab4f863f39adafd4c862f7ec01890abc	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.8.0	\N	\N	4561646186
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2022-09-30 18:14:10.70323	86	EXECUTED	8:13c419a0eb336e91ee3a3bf8fda6e2a7	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.8.0	\N	\N	4561646186
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2022-09-30 18:14:10.716897	87	EXECUTED	8:e3fb1e698e0471487f51af1ed80fe3ac	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.8.0	\N	\N	4561646186
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2022-09-30 18:14:10.731993	88	EXECUTED	8:babadb686aab7b56562817e60bf0abd0	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.8.0	\N	\N	4561646186
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-09-30 18:14:10.743581	89	EXECUTED	8:72d03345fda8e2f17093d08801947773	addColumn tableName=REALM; customChange		\N	4.8.0	\N	\N	4561646186
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-09-30 18:14:10.753866	90	EXECUTED	8:61c9233951bd96ffecd9ba75f7d978a4	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.8.0	\N	\N	4561646186
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-09-30 18:14:10.766651	91	EXECUTED	8:ea82e6ad945cec250af6372767b25525	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	4561646186
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-09-30 18:14:10.780936	92	EXECUTED	8:d3f4a33f41d960ddacd7e2ef30d126b3	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.8.0	\N	\N	4561646186
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-09-30 18:14:10.789114	93	MARK_RAN	8:1284a27fbd049d65831cb6fc07c8a783	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.8.0	\N	\N	4561646186
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-09-30 18:14:10.804409	94	EXECUTED	8:9d11b619db2ae27c25853b8a37cd0dea	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.8.0	\N	\N	4561646186
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-09-30 18:14:10.808463	95	MARK_RAN	8:3002bb3997451bb9e8bac5c5cd8d6327	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.8.0	\N	\N	4561646186
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-09-30 18:14:10.817044	96	EXECUTED	8:dfbee0d6237a23ef4ccbb7a4e063c163	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.8.0	\N	\N	4561646186
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-09-30 18:14:10.833566	97	EXECUTED	8:75f3e372df18d38c62734eebb986b960	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	4561646186
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-09-30 18:14:10.836994	98	MARK_RAN	8:7fee73eddf84a6035691512c85637eef	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	4561646186
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-09-30 18:14:10.850365	99	MARK_RAN	8:7a11134ab12820f999fbf3bb13c3adc8	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	4561646186
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-09-30 18:14:10.860346	100	EXECUTED	8:c0f6eaac1f3be773ffe54cb5b8482b70	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	4561646186
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-09-30 18:14:10.86334	101	MARK_RAN	8:18186f0008b86e0f0f49b0c4d0e842ac	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	4561646186
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-09-30 18:14:10.872975	102	EXECUTED	8:09c2780bcb23b310a7019d217dc7b433	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.8.0	\N	\N	4561646186
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-09-30 18:14:10.879808	103	EXECUTED	8:276a44955eab693c970a42880197fff2	customChange		\N	4.8.0	\N	\N	4561646186
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2022-09-30 18:14:10.889898	104	EXECUTED	8:ba8ee3b694d043f2bfc1a1079d0760d7	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.8.0	\N	\N	4561646186
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
1001	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
e47c4261-2e1f-40a1-a6b0-9430a59b71fd	fe921baa-ae75-4eb0-a28d-56c59da396d1	f
e47c4261-2e1f-40a1-a6b0-9430a59b71fd	478c8808-66a7-47f5-895a-67d1f9313a0a	t
e47c4261-2e1f-40a1-a6b0-9430a59b71fd	70bca347-d54f-4779-a6dd-de0b91110f94	t
e47c4261-2e1f-40a1-a6b0-9430a59b71fd	bf4bc2c0-263f-4105-8d69-da53aa5fb727	t
e47c4261-2e1f-40a1-a6b0-9430a59b71fd	1abbe72f-3c2c-4d62-b805-79e2e6983892	f
e47c4261-2e1f-40a1-a6b0-9430a59b71fd	062021a8-0ef2-436b-9c27-a85e387ca38f	f
e47c4261-2e1f-40a1-a6b0-9430a59b71fd	12649fa6-b956-4cc7-8a96-4623232d9645	t
e47c4261-2e1f-40a1-a6b0-9430a59b71fd	16afb0cc-9cf7-469b-8b13-170333db0c09	t
e47c4261-2e1f-40a1-a6b0-9430a59b71fd	c6d3c6c8-a27b-4f2b-91fc-2dc1e3782a04	f
e47c4261-2e1f-40a1-a6b0-9430a59b71fd	5b98c033-d03b-49ea-a3c4-7bcb3906ea65	t
912f0e36-c9a1-43b2-8a41-f3ef56854ae3	48f799ab-ab44-4058-8cea-73373b2e8a32	f
912f0e36-c9a1-43b2-8a41-f3ef56854ae3	a0980e08-4063-4f4b-961d-a6238809f7d6	t
912f0e36-c9a1-43b2-8a41-f3ef56854ae3	45fdb136-c454-41d6-98ad-5bcfe946bebe	t
912f0e36-c9a1-43b2-8a41-f3ef56854ae3	8985de0b-9b3a-4841-a4b1-9fe2accf619e	t
912f0e36-c9a1-43b2-8a41-f3ef56854ae3	9d537f5f-a2ac-4b28-a81f-51ce1af56815	f
912f0e36-c9a1-43b2-8a41-f3ef56854ae3	f479f754-80e5-4054-a0cd-7406fe1b1c85	f
912f0e36-c9a1-43b2-8a41-f3ef56854ae3	634fb130-fe94-4da8-91cd-42c07e684502	t
912f0e36-c9a1-43b2-8a41-f3ef56854ae3	1ffdf604-977d-4c34-9dc5-75d3002287c7	t
912f0e36-c9a1-43b2-8a41-f3ef56854ae3	9f4718d1-8087-41af-807d-7a6a838915f7	f
912f0e36-c9a1-43b2-8a41-f3ef56854ae3	b43e334f-9de4-4441-b905-429eddeb186b	t
912f0e36-c9a1-43b2-8a41-f3ef56854ae3	5c314bab-7d84-446e-a073-bbc976f3b4b9	t
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
de1ffa6c-ca11-4589-8cfd-ec67d0481c61	ArgoCDAdmins	 	912f0e36-c9a1-43b2-8a41-f3ef56854ae3
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
a262068b-d0e1-415e-96a2-ba6a73180eb1	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	f	${role_default-roles}	default-roles-master	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	\N	\N
b872bf24-9567-43b8-b17f-8a0c8b9d480a	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	f	${role_admin}	admin	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	\N	\N
c79acb00-7b8a-49c4-9cdc-a919ea39dc12	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	f	${role_create-realm}	create-realm	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	\N	\N
dec7a32b-1484-4371-aeae-b658fdc87884	87cb64f7-838a-423f-bc1b-1fe934f609a8	t	${role_create-client}	create-client	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	87cb64f7-838a-423f-bc1b-1fe934f609a8	\N
7a1efbe9-7e56-4fe0-9f96-4b0d15429762	87cb64f7-838a-423f-bc1b-1fe934f609a8	t	${role_view-realm}	view-realm	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	87cb64f7-838a-423f-bc1b-1fe934f609a8	\N
67fd17db-62a0-4088-8108-00e1a21048fa	87cb64f7-838a-423f-bc1b-1fe934f609a8	t	${role_view-users}	view-users	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	87cb64f7-838a-423f-bc1b-1fe934f609a8	\N
9df49db9-322c-4827-8fe5-88d33b9ce5bf	87cb64f7-838a-423f-bc1b-1fe934f609a8	t	${role_view-clients}	view-clients	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	87cb64f7-838a-423f-bc1b-1fe934f609a8	\N
00150b33-814c-40ba-8a0f-70f2128815f7	87cb64f7-838a-423f-bc1b-1fe934f609a8	t	${role_view-events}	view-events	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	87cb64f7-838a-423f-bc1b-1fe934f609a8	\N
c03ac27d-728e-4be2-92dd-27995593841d	87cb64f7-838a-423f-bc1b-1fe934f609a8	t	${role_view-identity-providers}	view-identity-providers	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	87cb64f7-838a-423f-bc1b-1fe934f609a8	\N
f397c451-2494-4389-b6e2-94716a16c5ef	87cb64f7-838a-423f-bc1b-1fe934f609a8	t	${role_view-authorization}	view-authorization	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	87cb64f7-838a-423f-bc1b-1fe934f609a8	\N
84609663-3229-4110-bcc0-e8100d341c21	87cb64f7-838a-423f-bc1b-1fe934f609a8	t	${role_manage-realm}	manage-realm	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	87cb64f7-838a-423f-bc1b-1fe934f609a8	\N
f8c4b0cf-a01b-40d4-9506-8f281aee450c	87cb64f7-838a-423f-bc1b-1fe934f609a8	t	${role_manage-users}	manage-users	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	87cb64f7-838a-423f-bc1b-1fe934f609a8	\N
9fcef069-45cd-493e-8600-ee3ce6e8e29a	87cb64f7-838a-423f-bc1b-1fe934f609a8	t	${role_manage-clients}	manage-clients	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	87cb64f7-838a-423f-bc1b-1fe934f609a8	\N
3cae7d36-4c78-4e31-8970-8fc190f4ca07	87cb64f7-838a-423f-bc1b-1fe934f609a8	t	${role_manage-events}	manage-events	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	87cb64f7-838a-423f-bc1b-1fe934f609a8	\N
78a2fff5-fa5e-420a-bb7b-456602bd03ee	87cb64f7-838a-423f-bc1b-1fe934f609a8	t	${role_manage-identity-providers}	manage-identity-providers	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	87cb64f7-838a-423f-bc1b-1fe934f609a8	\N
72d17e55-d9b6-4944-b543-30801ac54f79	87cb64f7-838a-423f-bc1b-1fe934f609a8	t	${role_manage-authorization}	manage-authorization	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	87cb64f7-838a-423f-bc1b-1fe934f609a8	\N
e241caa7-55a9-48c9-8b5d-f74e8957ac87	87cb64f7-838a-423f-bc1b-1fe934f609a8	t	${role_query-users}	query-users	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	87cb64f7-838a-423f-bc1b-1fe934f609a8	\N
774275b9-1a27-4e73-a0b4-96dd1fa768bb	87cb64f7-838a-423f-bc1b-1fe934f609a8	t	${role_query-clients}	query-clients	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	87cb64f7-838a-423f-bc1b-1fe934f609a8	\N
9e30e8a2-0374-4c52-b3b3-f237ae65ff4d	87cb64f7-838a-423f-bc1b-1fe934f609a8	t	${role_query-realms}	query-realms	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	87cb64f7-838a-423f-bc1b-1fe934f609a8	\N
def4fa49-81ef-4ab9-98ec-95c599c738f2	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	f	${role_default-roles}	default-roles-main	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	\N	\N
4aca9eb3-6030-49d7-b5ab-4cd1ec91d21a	e250b166-3cba-4c76-994e-fb54ee85771b	t	${role_create-client}	create-client	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	e250b166-3cba-4c76-994e-fb54ee85771b	\N
646ef6d2-0354-4585-aead-8ed91fff8534	e250b166-3cba-4c76-994e-fb54ee85771b	t	${role_view-realm}	view-realm	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	e250b166-3cba-4c76-994e-fb54ee85771b	\N
bf1a9ddf-23b3-47ba-90f4-1ed2659a3471	e250b166-3cba-4c76-994e-fb54ee85771b	t	${role_view-users}	view-users	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	e250b166-3cba-4c76-994e-fb54ee85771b	\N
c6cfbe04-0471-49e4-a569-cd4150ff7c8e	e250b166-3cba-4c76-994e-fb54ee85771b	t	${role_view-clients}	view-clients	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	e250b166-3cba-4c76-994e-fb54ee85771b	\N
de1cced5-43fd-4334-965e-5929fc2eed87	e250b166-3cba-4c76-994e-fb54ee85771b	t	${role_view-events}	view-events	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	e250b166-3cba-4c76-994e-fb54ee85771b	\N
fdd868da-74ee-446c-97ce-eaf3e96c6687	e250b166-3cba-4c76-994e-fb54ee85771b	t	${role_view-identity-providers}	view-identity-providers	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	e250b166-3cba-4c76-994e-fb54ee85771b	\N
57889376-837a-4ca3-97a5-56ff0bd19c02	e250b166-3cba-4c76-994e-fb54ee85771b	t	${role_view-authorization}	view-authorization	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	e250b166-3cba-4c76-994e-fb54ee85771b	\N
8c29e340-4cd2-4d81-8429-62c878efbf69	e250b166-3cba-4c76-994e-fb54ee85771b	t	${role_manage-realm}	manage-realm	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	e250b166-3cba-4c76-994e-fb54ee85771b	\N
ce31a9d8-92c5-461d-a36e-22325f8e30c6	87cb64f7-838a-423f-bc1b-1fe934f609a8	t	${role_query-groups}	query-groups	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	87cb64f7-838a-423f-bc1b-1fe934f609a8	\N
05af7506-90b6-4dfc-b0a0-4482fb1a5cea	a4b9d5b4-4506-46bd-9fae-97d61da1b553	t	${role_view-profile}	view-profile	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	a4b9d5b4-4506-46bd-9fae-97d61da1b553	\N
654969e7-5e26-4b96-b55e-fce2dc2b7e7e	a4b9d5b4-4506-46bd-9fae-97d61da1b553	t	${role_manage-account}	manage-account	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	a4b9d5b4-4506-46bd-9fae-97d61da1b553	\N
16022a41-41a7-492d-b0da-70b88826c098	a4b9d5b4-4506-46bd-9fae-97d61da1b553	t	${role_manage-account-links}	manage-account-links	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	a4b9d5b4-4506-46bd-9fae-97d61da1b553	\N
77b4ce4c-07ba-46f7-8e77-d37415ea43d2	a4b9d5b4-4506-46bd-9fae-97d61da1b553	t	${role_view-applications}	view-applications	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	a4b9d5b4-4506-46bd-9fae-97d61da1b553	\N
497dd88a-d892-428c-86cc-26d14d416163	a4b9d5b4-4506-46bd-9fae-97d61da1b553	t	${role_view-consent}	view-consent	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	a4b9d5b4-4506-46bd-9fae-97d61da1b553	\N
b3dc1a34-97ef-4f90-bc86-165babfc8ac7	a4b9d5b4-4506-46bd-9fae-97d61da1b553	t	${role_manage-consent}	manage-consent	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	a4b9d5b4-4506-46bd-9fae-97d61da1b553	\N
5ec02521-9838-44db-b097-89f403fa90cb	a4b9d5b4-4506-46bd-9fae-97d61da1b553	t	${role_delete-account}	delete-account	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	a4b9d5b4-4506-46bd-9fae-97d61da1b553	\N
45ea5f97-537e-43a0-aee0-202c4810003d	2fc17c2c-939d-4b4c-b1fa-fdfab1033b5d	t	${role_read-token}	read-token	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	2fc17c2c-939d-4b4c-b1fa-fdfab1033b5d	\N
22ffc36e-c621-4d87-9e2b-3fedf603cede	87cb64f7-838a-423f-bc1b-1fe934f609a8	t	${role_impersonation}	impersonation	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	87cb64f7-838a-423f-bc1b-1fe934f609a8	\N
c46487e1-9957-4665-8130-18e4b258d37e	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	f	${role_offline-access}	offline_access	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	\N	\N
f4cd14fa-0a11-44a8-806d-e611ceb766ef	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	f	${role_uma_authorization}	uma_authorization	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	\N	\N
05a26056-a4ac-4521-b25b-4e9748e9915a	e250b166-3cba-4c76-994e-fb54ee85771b	t	${role_manage-users}	manage-users	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	e250b166-3cba-4c76-994e-fb54ee85771b	\N
11ce42e6-bd6d-472e-8c85-bc106480e710	e250b166-3cba-4c76-994e-fb54ee85771b	t	${role_manage-clients}	manage-clients	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	e250b166-3cba-4c76-994e-fb54ee85771b	\N
6c34b098-d27c-4e49-bb82-6eeb7998e6c9	e250b166-3cba-4c76-994e-fb54ee85771b	t	${role_manage-events}	manage-events	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	e250b166-3cba-4c76-994e-fb54ee85771b	\N
c01d8979-3356-478f-98a5-2bc24387e624	e250b166-3cba-4c76-994e-fb54ee85771b	t	${role_manage-identity-providers}	manage-identity-providers	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	e250b166-3cba-4c76-994e-fb54ee85771b	\N
757c0431-8cf5-4276-8db2-00d4b659dec4	e250b166-3cba-4c76-994e-fb54ee85771b	t	${role_manage-authorization}	manage-authorization	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	e250b166-3cba-4c76-994e-fb54ee85771b	\N
044ab6cd-2427-4bd7-9d6c-7b950a63cb4f	e250b166-3cba-4c76-994e-fb54ee85771b	t	${role_query-users}	query-users	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	e250b166-3cba-4c76-994e-fb54ee85771b	\N
ab21d099-4d59-4521-beb2-51eff11e53ba	e250b166-3cba-4c76-994e-fb54ee85771b	t	${role_query-clients}	query-clients	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	e250b166-3cba-4c76-994e-fb54ee85771b	\N
34d0083f-cdd4-4ab5-af31-7c8aa873eea3	e250b166-3cba-4c76-994e-fb54ee85771b	t	${role_query-realms}	query-realms	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	e250b166-3cba-4c76-994e-fb54ee85771b	\N
f2284e81-8447-4ba6-b706-3c35de78af89	e250b166-3cba-4c76-994e-fb54ee85771b	t	${role_query-groups}	query-groups	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	e250b166-3cba-4c76-994e-fb54ee85771b	\N
b9f1daa9-d3af-45a0-b3c7-18ea6df62665	e250b166-3cba-4c76-994e-fb54ee85771b	t	${role_impersonation}	impersonation	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	e250b166-3cba-4c76-994e-fb54ee85771b	\N
de0b898b-defc-494b-9178-b2b2864a9646	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	f	${role_offline-access}	offline_access	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	\N	\N
05a332db-0e3f-40c6-a099-daa630e1c15f	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	f	${role_uma_authorization}	uma_authorization	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	\N	\N
1fb0b090-9878-41f0-a857-d273e06d9c84	11360bd3-a08f-4223-87a1-fa1990a6f7cf	t	${role_view-clients}	view-clients	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	11360bd3-a08f-4223-87a1-fa1990a6f7cf	\N
a532a69f-8925-48cf-ae42-c660d3d6fc4c	11360bd3-a08f-4223-87a1-fa1990a6f7cf	t	${role_view-realm}	view-realm	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	11360bd3-a08f-4223-87a1-fa1990a6f7cf	\N
c5a7b6e1-aea2-4d52-98e5-ff294b90e116	11360bd3-a08f-4223-87a1-fa1990a6f7cf	t	${role_view-users}	view-users	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	11360bd3-a08f-4223-87a1-fa1990a6f7cf	\N
d3e4633f-8c2a-489b-a656-e7e888c1deba	11360bd3-a08f-4223-87a1-fa1990a6f7cf	t	${role_impersonation}	impersonation	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	11360bd3-a08f-4223-87a1-fa1990a6f7cf	\N
216d4630-d140-4b06-9be7-ee52cf105d59	11360bd3-a08f-4223-87a1-fa1990a6f7cf	t	${role_manage-identity-providers}	manage-identity-providers	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	11360bd3-a08f-4223-87a1-fa1990a6f7cf	\N
97ba89cc-d6d2-4688-9ef0-a3a7dce1b7ab	11360bd3-a08f-4223-87a1-fa1990a6f7cf	t	${role_view-identity-providers}	view-identity-providers	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	11360bd3-a08f-4223-87a1-fa1990a6f7cf	\N
dbd4a13d-d2a4-4cdd-a47f-bfb6d7b8df7e	11360bd3-a08f-4223-87a1-fa1990a6f7cf	t	${role_manage-users}	manage-users	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	11360bd3-a08f-4223-87a1-fa1990a6f7cf	\N
a56a0a0d-a808-44f4-b1fb-2b564e51e72f	11360bd3-a08f-4223-87a1-fa1990a6f7cf	t	${role_view-authorization}	view-authorization	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	11360bd3-a08f-4223-87a1-fa1990a6f7cf	\N
6a0346cc-e003-4584-8039-72b8dc522e06	11360bd3-a08f-4223-87a1-fa1990a6f7cf	t	${role_query-clients}	query-clients	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	11360bd3-a08f-4223-87a1-fa1990a6f7cf	\N
6d8244f7-4de1-419c-b586-9b1c7aa4cc1f	11360bd3-a08f-4223-87a1-fa1990a6f7cf	t	${role_manage-clients}	manage-clients	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	11360bd3-a08f-4223-87a1-fa1990a6f7cf	\N
fa057fb0-f14b-42f5-b07e-2aa9872429fa	11360bd3-a08f-4223-87a1-fa1990a6f7cf	t	${role_query-realms}	query-realms	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	11360bd3-a08f-4223-87a1-fa1990a6f7cf	\N
62effce6-7be6-4a48-9a83-3d94c4b31555	11360bd3-a08f-4223-87a1-fa1990a6f7cf	t	${role_query-users}	query-users	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	11360bd3-a08f-4223-87a1-fa1990a6f7cf	\N
a3f7750e-3864-416b-b9fe-92ce4fb2413a	11360bd3-a08f-4223-87a1-fa1990a6f7cf	t	${role_manage-events}	manage-events	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	11360bd3-a08f-4223-87a1-fa1990a6f7cf	\N
47a6d194-853d-4b53-afb0-151e0c1cddf3	11360bd3-a08f-4223-87a1-fa1990a6f7cf	t	${role_manage-realm}	manage-realm	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	11360bd3-a08f-4223-87a1-fa1990a6f7cf	\N
90e4d2ca-a323-4918-a25a-e66b866e9a04	11360bd3-a08f-4223-87a1-fa1990a6f7cf	t	${role_view-events}	view-events	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	11360bd3-a08f-4223-87a1-fa1990a6f7cf	\N
7c7bba8b-2382-4350-bb32-c0c211fe1f3c	11360bd3-a08f-4223-87a1-fa1990a6f7cf	t	${role_create-client}	create-client	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	11360bd3-a08f-4223-87a1-fa1990a6f7cf	\N
7e8f6ee5-8dda-40ed-9ca3-7aca90eb4f1f	11360bd3-a08f-4223-87a1-fa1990a6f7cf	t	${role_manage-authorization}	manage-authorization	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	11360bd3-a08f-4223-87a1-fa1990a6f7cf	\N
e602022d-ea8f-4347-8340-a5c7566e0125	11360bd3-a08f-4223-87a1-fa1990a6f7cf	t	${role_realm-admin}	realm-admin	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	11360bd3-a08f-4223-87a1-fa1990a6f7cf	\N
a7adbf98-5c6c-4993-83ca-d69358ba204e	11360bd3-a08f-4223-87a1-fa1990a6f7cf	t	${role_query-groups}	query-groups	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	11360bd3-a08f-4223-87a1-fa1990a6f7cf	\N
9f49c42b-ffbe-42de-8ffe-48fc5c39eff5	66862fec-33ea-4c4d-a38e-0946f3b33ebb	t	${role_read-token}	read-token	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	66862fec-33ea-4c4d-a38e-0946f3b33ebb	\N
19944c2e-b022-4ecc-8be6-ff44e9fe1c27	d15f4ea4-a056-439d-8eac-ea5743e8693a	t	${role_view-applications}	view-applications	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	d15f4ea4-a056-439d-8eac-ea5743e8693a	\N
1f253b45-9c30-4271-8525-5ff99ed4d172	d15f4ea4-a056-439d-8eac-ea5743e8693a	t	${role_manage-account}	manage-account	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	d15f4ea4-a056-439d-8eac-ea5743e8693a	\N
50d6ecab-247f-4922-9344-84a8ecfc83e6	d15f4ea4-a056-439d-8eac-ea5743e8693a	t	${role_manage-account-links}	manage-account-links	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	d15f4ea4-a056-439d-8eac-ea5743e8693a	\N
ece0f74a-2e31-4397-a60d-7ecc9cd90697	d15f4ea4-a056-439d-8eac-ea5743e8693a	t	${role_delete-account}	delete-account	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	d15f4ea4-a056-439d-8eac-ea5743e8693a	\N
db003945-aaa8-45ed-89fc-86803b34ab9b	d15f4ea4-a056-439d-8eac-ea5743e8693a	t	${role_view-consent}	view-consent	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	d15f4ea4-a056-439d-8eac-ea5743e8693a	\N
53fcd7d7-bb16-4a47-8eba-bab5d5deddb3	d15f4ea4-a056-439d-8eac-ea5743e8693a	t	${role_manage-consent}	manage-consent	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	d15f4ea4-a056-439d-8eac-ea5743e8693a	\N
66ded48b-cce4-4511-9d3a-12a9dd5131c4	d15f4ea4-a056-439d-8eac-ea5743e8693a	t	${role_view-profile}	view-profile	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	d15f4ea4-a056-439d-8eac-ea5743e8693a	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.migration_model (id, version, update_time) FROM stdin;
qnsy7	19.0.2	1664561651
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
aa229359-bf37-452b-8f04-d7d27f8711da	audience resolve	openid-connect	oidc-audience-resolve-mapper	67e37d4b-6f6f-43ff-b761-e3692dca9c05	\N
0a21f621-2900-45fb-a245-05edcd4d78b1	locale	openid-connect	oidc-usermodel-attribute-mapper	ddd67d36-1bb3-4ad3-bb85-07934e174e09	\N
ad6a72d4-d48d-46bf-8ba9-e1ca6a384f2d	role list	saml	saml-role-list-mapper	\N	478c8808-66a7-47f5-895a-67d1f9313a0a
59330a8b-847a-4926-a344-4367f42b8bfa	full name	openid-connect	oidc-full-name-mapper	\N	70bca347-d54f-4779-a6dd-de0b91110f94
104807cf-10a9-4da1-be66-78fc708711c1	family name	openid-connect	oidc-usermodel-property-mapper	\N	70bca347-d54f-4779-a6dd-de0b91110f94
976fad2d-b59c-47ec-b1c1-e1883bf508b9	given name	openid-connect	oidc-usermodel-property-mapper	\N	70bca347-d54f-4779-a6dd-de0b91110f94
e48e1b47-c192-402c-a4a1-66a304663c05	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	70bca347-d54f-4779-a6dd-de0b91110f94
12fa425a-64be-406c-9c71-084c8f3df71e	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	70bca347-d54f-4779-a6dd-de0b91110f94
b879ff0f-92de-4813-8cff-d8ceb8910a97	username	openid-connect	oidc-usermodel-property-mapper	\N	70bca347-d54f-4779-a6dd-de0b91110f94
bd04a1f2-d93d-439d-b975-328c6fadfdaf	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	70bca347-d54f-4779-a6dd-de0b91110f94
c6876c31-3c45-40f4-b165-3996e04f7c3e	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	70bca347-d54f-4779-a6dd-de0b91110f94
d612b712-7978-48ac-bf0c-e981903ad3b3	website	openid-connect	oidc-usermodel-attribute-mapper	\N	70bca347-d54f-4779-a6dd-de0b91110f94
c7864670-693a-4f08-9060-415282a28c87	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	70bca347-d54f-4779-a6dd-de0b91110f94
6cce7f0e-4f2d-4eb8-8b71-7fc35320f908	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	70bca347-d54f-4779-a6dd-de0b91110f94
41afa991-4824-4514-ac82-180b37d943c4	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	70bca347-d54f-4779-a6dd-de0b91110f94
bacd263e-9b32-43ec-8123-9e72afce5648	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	70bca347-d54f-4779-a6dd-de0b91110f94
5f717335-99ca-43ca-8891-60b1423f8fdf	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	70bca347-d54f-4779-a6dd-de0b91110f94
8c6880b4-61a6-439c-a7b9-55c7f88cc84d	email	openid-connect	oidc-usermodel-property-mapper	\N	bf4bc2c0-263f-4105-8d69-da53aa5fb727
751b960b-2756-49a2-8b5b-612bb06e5f91	email verified	openid-connect	oidc-usermodel-property-mapper	\N	bf4bc2c0-263f-4105-8d69-da53aa5fb727
bf1f5635-c403-44a0-9943-4fec005bf957	address	openid-connect	oidc-address-mapper	\N	1abbe72f-3c2c-4d62-b805-79e2e6983892
d2628018-fb55-472b-bcde-55d7a77409be	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	062021a8-0ef2-436b-9c27-a85e387ca38f
36564095-c091-46c4-8c0a-5e308df103b2	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	062021a8-0ef2-436b-9c27-a85e387ca38f
707cc512-74aa-4709-bc95-19d88db1ed5b	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	12649fa6-b956-4cc7-8a96-4623232d9645
616b7794-47a7-4356-b2fa-7117ca58932f	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	12649fa6-b956-4cc7-8a96-4623232d9645
07589156-681d-4eb1-a084-5d3c230d28f4	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	12649fa6-b956-4cc7-8a96-4623232d9645
3eb2a16e-0430-4eaa-ac09-14b63bdc07a7	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	16afb0cc-9cf7-469b-8b13-170333db0c09
be844e8d-18fa-40ca-b2c6-a5669c353fc1	upn	openid-connect	oidc-usermodel-property-mapper	\N	c6d3c6c8-a27b-4f2b-91fc-2dc1e3782a04
32458cee-563e-4a12-9b32-9404691c5462	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	c6d3c6c8-a27b-4f2b-91fc-2dc1e3782a04
f3c7a6a7-51ce-48e6-bb2a-0b056ebff69e	acr loa level	openid-connect	oidc-acr-mapper	\N	5b98c033-d03b-49ea-a3c4-7bcb3906ea65
6d3bc67d-6170-461d-a78b-a6d82ea55a6b	role list	saml	saml-role-list-mapper	\N	a0980e08-4063-4f4b-961d-a6238809f7d6
40e8ad57-8d59-4e3d-9e35-8458f3fbb7d8	full name	openid-connect	oidc-full-name-mapper	\N	45fdb136-c454-41d6-98ad-5bcfe946bebe
39f05c91-ad80-470c-9c29-7740306a313a	family name	openid-connect	oidc-usermodel-property-mapper	\N	45fdb136-c454-41d6-98ad-5bcfe946bebe
8555784f-031c-4848-9781-feb4de4972bb	given name	openid-connect	oidc-usermodel-property-mapper	\N	45fdb136-c454-41d6-98ad-5bcfe946bebe
e21669de-2640-4a0f-a87e-e0911b470da2	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	45fdb136-c454-41d6-98ad-5bcfe946bebe
d2571775-6d47-4e70-b597-9a3de48a464c	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	45fdb136-c454-41d6-98ad-5bcfe946bebe
685aeb2a-a407-45b4-8072-6f53e52a2b64	username	openid-connect	oidc-usermodel-property-mapper	\N	45fdb136-c454-41d6-98ad-5bcfe946bebe
e8fe9831-d658-466e-b143-dd31b00d01db	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	45fdb136-c454-41d6-98ad-5bcfe946bebe
7115d347-9751-44d4-bd15-55f56892ceed	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	45fdb136-c454-41d6-98ad-5bcfe946bebe
82ec0110-b217-4615-8525-aeee661b2d39	website	openid-connect	oidc-usermodel-attribute-mapper	\N	45fdb136-c454-41d6-98ad-5bcfe946bebe
df8a7aaf-afe3-4589-9056-afe0c7debb64	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	45fdb136-c454-41d6-98ad-5bcfe946bebe
7bc5ef25-0b80-4424-9b01-402b9ec0501d	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	45fdb136-c454-41d6-98ad-5bcfe946bebe
3540a2fc-b8aa-46b0-99d9-e3fa20e81891	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	45fdb136-c454-41d6-98ad-5bcfe946bebe
13db3113-c3e1-4b0d-b3f4-e01b32478ef2	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	45fdb136-c454-41d6-98ad-5bcfe946bebe
c9c45c64-ad00-4832-9a30-9b215723d692	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	45fdb136-c454-41d6-98ad-5bcfe946bebe
7579d79d-3ac0-46b2-86f5-10c7087e902e	email	openid-connect	oidc-usermodel-property-mapper	\N	8985de0b-9b3a-4841-a4b1-9fe2accf619e
843fd7ef-901b-47dc-a7f8-87a9c0f94ed8	email verified	openid-connect	oidc-usermodel-property-mapper	\N	8985de0b-9b3a-4841-a4b1-9fe2accf619e
ceceb372-3e4e-427d-91f0-5f0396fff6a8	address	openid-connect	oidc-address-mapper	\N	9d537f5f-a2ac-4b28-a81f-51ce1af56815
afc88ce5-2019-42cd-b9d4-d1a35ebe5783	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	f479f754-80e5-4054-a0cd-7406fe1b1c85
10816028-54e7-4ddf-a09b-dccf913a0420	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	f479f754-80e5-4054-a0cd-7406fe1b1c85
f6fbb345-6ab1-488e-9de5-eb9248ec47d2	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	634fb130-fe94-4da8-91cd-42c07e684502
6398cb1d-ef01-42f4-a409-0f7c3629faa4	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	634fb130-fe94-4da8-91cd-42c07e684502
5e81286c-bd9d-44ae-93c5-a2e2b5fa0745	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	634fb130-fe94-4da8-91cd-42c07e684502
1c933522-0e88-4c76-b29e-f9d9b8df143b	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	1ffdf604-977d-4c34-9dc5-75d3002287c7
77d43e4d-a362-473f-9d00-1298aab76142	upn	openid-connect	oidc-usermodel-property-mapper	\N	9f4718d1-8087-41af-807d-7a6a838915f7
a49c4fe8-877a-4d56-9903-af71ec27fd33	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	9f4718d1-8087-41af-807d-7a6a838915f7
3bf1426d-cf9a-49a4-99c0-3731b59f87cd	acr loa level	openid-connect	oidc-acr-mapper	\N	b43e334f-9de4-4441-b905-429eddeb186b
5bc28e7a-ff7c-4d73-b41e-9f2f66fd7b33	locale	openid-connect	oidc-usermodel-attribute-mapper	854ef916-6fc8-4da4-a6ca-a1a0ac16cd66	\N
1dddae7a-d227-42f0-b66a-cf6ad2c33886	audience resolve	openid-connect	oidc-audience-resolve-mapper	fbd356ac-40ee-470f-a677-7158e3c3c401	\N
6ffbb9ef-54ec-410f-9a2f-d347db7df6e4	argocd_clients	openid-connect	oidc-group-membership-mapper	\N	5c314bab-7d84-446e-a073-bbc976f3b4b9
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
0a21f621-2900-45fb-a245-05edcd4d78b1	true	userinfo.token.claim
0a21f621-2900-45fb-a245-05edcd4d78b1	locale	user.attribute
0a21f621-2900-45fb-a245-05edcd4d78b1	true	id.token.claim
0a21f621-2900-45fb-a245-05edcd4d78b1	true	access.token.claim
0a21f621-2900-45fb-a245-05edcd4d78b1	locale	claim.name
0a21f621-2900-45fb-a245-05edcd4d78b1	String	jsonType.label
ad6a72d4-d48d-46bf-8ba9-e1ca6a384f2d	false	single
ad6a72d4-d48d-46bf-8ba9-e1ca6a384f2d	Basic	attribute.nameformat
ad6a72d4-d48d-46bf-8ba9-e1ca6a384f2d	Role	attribute.name
104807cf-10a9-4da1-be66-78fc708711c1	true	userinfo.token.claim
104807cf-10a9-4da1-be66-78fc708711c1	lastName	user.attribute
104807cf-10a9-4da1-be66-78fc708711c1	true	id.token.claim
104807cf-10a9-4da1-be66-78fc708711c1	true	access.token.claim
104807cf-10a9-4da1-be66-78fc708711c1	family_name	claim.name
104807cf-10a9-4da1-be66-78fc708711c1	String	jsonType.label
12fa425a-64be-406c-9c71-084c8f3df71e	true	userinfo.token.claim
12fa425a-64be-406c-9c71-084c8f3df71e	nickname	user.attribute
12fa425a-64be-406c-9c71-084c8f3df71e	true	id.token.claim
12fa425a-64be-406c-9c71-084c8f3df71e	true	access.token.claim
12fa425a-64be-406c-9c71-084c8f3df71e	nickname	claim.name
12fa425a-64be-406c-9c71-084c8f3df71e	String	jsonType.label
41afa991-4824-4514-ac82-180b37d943c4	true	userinfo.token.claim
41afa991-4824-4514-ac82-180b37d943c4	zoneinfo	user.attribute
41afa991-4824-4514-ac82-180b37d943c4	true	id.token.claim
41afa991-4824-4514-ac82-180b37d943c4	true	access.token.claim
41afa991-4824-4514-ac82-180b37d943c4	zoneinfo	claim.name
41afa991-4824-4514-ac82-180b37d943c4	String	jsonType.label
59330a8b-847a-4926-a344-4367f42b8bfa	true	userinfo.token.claim
59330a8b-847a-4926-a344-4367f42b8bfa	true	id.token.claim
59330a8b-847a-4926-a344-4367f42b8bfa	true	access.token.claim
5f717335-99ca-43ca-8891-60b1423f8fdf	true	userinfo.token.claim
5f717335-99ca-43ca-8891-60b1423f8fdf	updatedAt	user.attribute
5f717335-99ca-43ca-8891-60b1423f8fdf	true	id.token.claim
5f717335-99ca-43ca-8891-60b1423f8fdf	true	access.token.claim
5f717335-99ca-43ca-8891-60b1423f8fdf	updated_at	claim.name
5f717335-99ca-43ca-8891-60b1423f8fdf	long	jsonType.label
6cce7f0e-4f2d-4eb8-8b71-7fc35320f908	true	userinfo.token.claim
6cce7f0e-4f2d-4eb8-8b71-7fc35320f908	birthdate	user.attribute
6cce7f0e-4f2d-4eb8-8b71-7fc35320f908	true	id.token.claim
6cce7f0e-4f2d-4eb8-8b71-7fc35320f908	true	access.token.claim
6cce7f0e-4f2d-4eb8-8b71-7fc35320f908	birthdate	claim.name
6cce7f0e-4f2d-4eb8-8b71-7fc35320f908	String	jsonType.label
976fad2d-b59c-47ec-b1c1-e1883bf508b9	true	userinfo.token.claim
976fad2d-b59c-47ec-b1c1-e1883bf508b9	firstName	user.attribute
976fad2d-b59c-47ec-b1c1-e1883bf508b9	true	id.token.claim
976fad2d-b59c-47ec-b1c1-e1883bf508b9	true	access.token.claim
976fad2d-b59c-47ec-b1c1-e1883bf508b9	given_name	claim.name
976fad2d-b59c-47ec-b1c1-e1883bf508b9	String	jsonType.label
b879ff0f-92de-4813-8cff-d8ceb8910a97	true	userinfo.token.claim
b879ff0f-92de-4813-8cff-d8ceb8910a97	username	user.attribute
b879ff0f-92de-4813-8cff-d8ceb8910a97	true	id.token.claim
b879ff0f-92de-4813-8cff-d8ceb8910a97	true	access.token.claim
b879ff0f-92de-4813-8cff-d8ceb8910a97	preferred_username	claim.name
b879ff0f-92de-4813-8cff-d8ceb8910a97	String	jsonType.label
bacd263e-9b32-43ec-8123-9e72afce5648	true	userinfo.token.claim
bacd263e-9b32-43ec-8123-9e72afce5648	locale	user.attribute
bacd263e-9b32-43ec-8123-9e72afce5648	true	id.token.claim
bacd263e-9b32-43ec-8123-9e72afce5648	true	access.token.claim
bacd263e-9b32-43ec-8123-9e72afce5648	locale	claim.name
bacd263e-9b32-43ec-8123-9e72afce5648	String	jsonType.label
bd04a1f2-d93d-439d-b975-328c6fadfdaf	true	userinfo.token.claim
bd04a1f2-d93d-439d-b975-328c6fadfdaf	profile	user.attribute
bd04a1f2-d93d-439d-b975-328c6fadfdaf	true	id.token.claim
bd04a1f2-d93d-439d-b975-328c6fadfdaf	true	access.token.claim
bd04a1f2-d93d-439d-b975-328c6fadfdaf	profile	claim.name
bd04a1f2-d93d-439d-b975-328c6fadfdaf	String	jsonType.label
c6876c31-3c45-40f4-b165-3996e04f7c3e	true	userinfo.token.claim
c6876c31-3c45-40f4-b165-3996e04f7c3e	picture	user.attribute
c6876c31-3c45-40f4-b165-3996e04f7c3e	true	id.token.claim
c6876c31-3c45-40f4-b165-3996e04f7c3e	true	access.token.claim
c6876c31-3c45-40f4-b165-3996e04f7c3e	picture	claim.name
c6876c31-3c45-40f4-b165-3996e04f7c3e	String	jsonType.label
c7864670-693a-4f08-9060-415282a28c87	true	userinfo.token.claim
c7864670-693a-4f08-9060-415282a28c87	gender	user.attribute
c7864670-693a-4f08-9060-415282a28c87	true	id.token.claim
c7864670-693a-4f08-9060-415282a28c87	true	access.token.claim
c7864670-693a-4f08-9060-415282a28c87	gender	claim.name
c7864670-693a-4f08-9060-415282a28c87	String	jsonType.label
d612b712-7978-48ac-bf0c-e981903ad3b3	true	userinfo.token.claim
d612b712-7978-48ac-bf0c-e981903ad3b3	website	user.attribute
d612b712-7978-48ac-bf0c-e981903ad3b3	true	id.token.claim
d612b712-7978-48ac-bf0c-e981903ad3b3	true	access.token.claim
d612b712-7978-48ac-bf0c-e981903ad3b3	website	claim.name
d612b712-7978-48ac-bf0c-e981903ad3b3	String	jsonType.label
e48e1b47-c192-402c-a4a1-66a304663c05	true	userinfo.token.claim
e48e1b47-c192-402c-a4a1-66a304663c05	middleName	user.attribute
e48e1b47-c192-402c-a4a1-66a304663c05	true	id.token.claim
e48e1b47-c192-402c-a4a1-66a304663c05	true	access.token.claim
e48e1b47-c192-402c-a4a1-66a304663c05	middle_name	claim.name
e48e1b47-c192-402c-a4a1-66a304663c05	String	jsonType.label
751b960b-2756-49a2-8b5b-612bb06e5f91	true	userinfo.token.claim
751b960b-2756-49a2-8b5b-612bb06e5f91	emailVerified	user.attribute
751b960b-2756-49a2-8b5b-612bb06e5f91	true	id.token.claim
751b960b-2756-49a2-8b5b-612bb06e5f91	true	access.token.claim
751b960b-2756-49a2-8b5b-612bb06e5f91	email_verified	claim.name
751b960b-2756-49a2-8b5b-612bb06e5f91	boolean	jsonType.label
8c6880b4-61a6-439c-a7b9-55c7f88cc84d	true	userinfo.token.claim
8c6880b4-61a6-439c-a7b9-55c7f88cc84d	email	user.attribute
8c6880b4-61a6-439c-a7b9-55c7f88cc84d	true	id.token.claim
8c6880b4-61a6-439c-a7b9-55c7f88cc84d	true	access.token.claim
8c6880b4-61a6-439c-a7b9-55c7f88cc84d	email	claim.name
8c6880b4-61a6-439c-a7b9-55c7f88cc84d	String	jsonType.label
bf1f5635-c403-44a0-9943-4fec005bf957	formatted	user.attribute.formatted
bf1f5635-c403-44a0-9943-4fec005bf957	country	user.attribute.country
bf1f5635-c403-44a0-9943-4fec005bf957	postal_code	user.attribute.postal_code
bf1f5635-c403-44a0-9943-4fec005bf957	true	userinfo.token.claim
bf1f5635-c403-44a0-9943-4fec005bf957	street	user.attribute.street
bf1f5635-c403-44a0-9943-4fec005bf957	true	id.token.claim
bf1f5635-c403-44a0-9943-4fec005bf957	region	user.attribute.region
bf1f5635-c403-44a0-9943-4fec005bf957	true	access.token.claim
bf1f5635-c403-44a0-9943-4fec005bf957	locality	user.attribute.locality
36564095-c091-46c4-8c0a-5e308df103b2	true	userinfo.token.claim
36564095-c091-46c4-8c0a-5e308df103b2	phoneNumberVerified	user.attribute
36564095-c091-46c4-8c0a-5e308df103b2	true	id.token.claim
36564095-c091-46c4-8c0a-5e308df103b2	true	access.token.claim
36564095-c091-46c4-8c0a-5e308df103b2	phone_number_verified	claim.name
36564095-c091-46c4-8c0a-5e308df103b2	boolean	jsonType.label
d2628018-fb55-472b-bcde-55d7a77409be	true	userinfo.token.claim
d2628018-fb55-472b-bcde-55d7a77409be	phoneNumber	user.attribute
d2628018-fb55-472b-bcde-55d7a77409be	true	id.token.claim
d2628018-fb55-472b-bcde-55d7a77409be	true	access.token.claim
d2628018-fb55-472b-bcde-55d7a77409be	phone_number	claim.name
d2628018-fb55-472b-bcde-55d7a77409be	String	jsonType.label
616b7794-47a7-4356-b2fa-7117ca58932f	true	multivalued
616b7794-47a7-4356-b2fa-7117ca58932f	foo	user.attribute
616b7794-47a7-4356-b2fa-7117ca58932f	true	access.token.claim
616b7794-47a7-4356-b2fa-7117ca58932f	resource_access.${client_id}.roles	claim.name
616b7794-47a7-4356-b2fa-7117ca58932f	String	jsonType.label
707cc512-74aa-4709-bc95-19d88db1ed5b	true	multivalued
707cc512-74aa-4709-bc95-19d88db1ed5b	foo	user.attribute
707cc512-74aa-4709-bc95-19d88db1ed5b	true	access.token.claim
707cc512-74aa-4709-bc95-19d88db1ed5b	realm_access.roles	claim.name
707cc512-74aa-4709-bc95-19d88db1ed5b	String	jsonType.label
32458cee-563e-4a12-9b32-9404691c5462	true	multivalued
32458cee-563e-4a12-9b32-9404691c5462	foo	user.attribute
32458cee-563e-4a12-9b32-9404691c5462	true	id.token.claim
32458cee-563e-4a12-9b32-9404691c5462	true	access.token.claim
32458cee-563e-4a12-9b32-9404691c5462	groups	claim.name
32458cee-563e-4a12-9b32-9404691c5462	String	jsonType.label
be844e8d-18fa-40ca-b2c6-a5669c353fc1	true	userinfo.token.claim
be844e8d-18fa-40ca-b2c6-a5669c353fc1	username	user.attribute
be844e8d-18fa-40ca-b2c6-a5669c353fc1	true	id.token.claim
be844e8d-18fa-40ca-b2c6-a5669c353fc1	true	access.token.claim
be844e8d-18fa-40ca-b2c6-a5669c353fc1	upn	claim.name
be844e8d-18fa-40ca-b2c6-a5669c353fc1	String	jsonType.label
f3c7a6a7-51ce-48e6-bb2a-0b056ebff69e	true	id.token.claim
f3c7a6a7-51ce-48e6-bb2a-0b056ebff69e	true	access.token.claim
6d3bc67d-6170-461d-a78b-a6d82ea55a6b	false	single
6d3bc67d-6170-461d-a78b-a6d82ea55a6b	Basic	attribute.nameformat
6d3bc67d-6170-461d-a78b-a6d82ea55a6b	Role	attribute.name
13db3113-c3e1-4b0d-b3f4-e01b32478ef2	true	userinfo.token.claim
13db3113-c3e1-4b0d-b3f4-e01b32478ef2	locale	user.attribute
13db3113-c3e1-4b0d-b3f4-e01b32478ef2	true	id.token.claim
13db3113-c3e1-4b0d-b3f4-e01b32478ef2	true	access.token.claim
13db3113-c3e1-4b0d-b3f4-e01b32478ef2	locale	claim.name
13db3113-c3e1-4b0d-b3f4-e01b32478ef2	String	jsonType.label
3540a2fc-b8aa-46b0-99d9-e3fa20e81891	true	userinfo.token.claim
3540a2fc-b8aa-46b0-99d9-e3fa20e81891	zoneinfo	user.attribute
3540a2fc-b8aa-46b0-99d9-e3fa20e81891	true	id.token.claim
3540a2fc-b8aa-46b0-99d9-e3fa20e81891	true	access.token.claim
3540a2fc-b8aa-46b0-99d9-e3fa20e81891	zoneinfo	claim.name
3540a2fc-b8aa-46b0-99d9-e3fa20e81891	String	jsonType.label
39f05c91-ad80-470c-9c29-7740306a313a	true	userinfo.token.claim
39f05c91-ad80-470c-9c29-7740306a313a	lastName	user.attribute
39f05c91-ad80-470c-9c29-7740306a313a	true	id.token.claim
39f05c91-ad80-470c-9c29-7740306a313a	true	access.token.claim
39f05c91-ad80-470c-9c29-7740306a313a	family_name	claim.name
39f05c91-ad80-470c-9c29-7740306a313a	String	jsonType.label
40e8ad57-8d59-4e3d-9e35-8458f3fbb7d8	true	userinfo.token.claim
40e8ad57-8d59-4e3d-9e35-8458f3fbb7d8	true	id.token.claim
40e8ad57-8d59-4e3d-9e35-8458f3fbb7d8	true	access.token.claim
685aeb2a-a407-45b4-8072-6f53e52a2b64	true	userinfo.token.claim
685aeb2a-a407-45b4-8072-6f53e52a2b64	username	user.attribute
685aeb2a-a407-45b4-8072-6f53e52a2b64	true	id.token.claim
685aeb2a-a407-45b4-8072-6f53e52a2b64	true	access.token.claim
685aeb2a-a407-45b4-8072-6f53e52a2b64	preferred_username	claim.name
685aeb2a-a407-45b4-8072-6f53e52a2b64	String	jsonType.label
7115d347-9751-44d4-bd15-55f56892ceed	true	userinfo.token.claim
7115d347-9751-44d4-bd15-55f56892ceed	picture	user.attribute
7115d347-9751-44d4-bd15-55f56892ceed	true	id.token.claim
7115d347-9751-44d4-bd15-55f56892ceed	true	access.token.claim
7115d347-9751-44d4-bd15-55f56892ceed	picture	claim.name
7115d347-9751-44d4-bd15-55f56892ceed	String	jsonType.label
7bc5ef25-0b80-4424-9b01-402b9ec0501d	true	userinfo.token.claim
7bc5ef25-0b80-4424-9b01-402b9ec0501d	birthdate	user.attribute
7bc5ef25-0b80-4424-9b01-402b9ec0501d	true	id.token.claim
7bc5ef25-0b80-4424-9b01-402b9ec0501d	true	access.token.claim
7bc5ef25-0b80-4424-9b01-402b9ec0501d	birthdate	claim.name
7bc5ef25-0b80-4424-9b01-402b9ec0501d	String	jsonType.label
82ec0110-b217-4615-8525-aeee661b2d39	true	userinfo.token.claim
82ec0110-b217-4615-8525-aeee661b2d39	website	user.attribute
82ec0110-b217-4615-8525-aeee661b2d39	true	id.token.claim
82ec0110-b217-4615-8525-aeee661b2d39	true	access.token.claim
82ec0110-b217-4615-8525-aeee661b2d39	website	claim.name
82ec0110-b217-4615-8525-aeee661b2d39	String	jsonType.label
8555784f-031c-4848-9781-feb4de4972bb	true	userinfo.token.claim
8555784f-031c-4848-9781-feb4de4972bb	firstName	user.attribute
8555784f-031c-4848-9781-feb4de4972bb	true	id.token.claim
8555784f-031c-4848-9781-feb4de4972bb	true	access.token.claim
8555784f-031c-4848-9781-feb4de4972bb	given_name	claim.name
8555784f-031c-4848-9781-feb4de4972bb	String	jsonType.label
c9c45c64-ad00-4832-9a30-9b215723d692	true	userinfo.token.claim
c9c45c64-ad00-4832-9a30-9b215723d692	updatedAt	user.attribute
c9c45c64-ad00-4832-9a30-9b215723d692	true	id.token.claim
c9c45c64-ad00-4832-9a30-9b215723d692	true	access.token.claim
c9c45c64-ad00-4832-9a30-9b215723d692	updated_at	claim.name
c9c45c64-ad00-4832-9a30-9b215723d692	long	jsonType.label
d2571775-6d47-4e70-b597-9a3de48a464c	true	userinfo.token.claim
d2571775-6d47-4e70-b597-9a3de48a464c	nickname	user.attribute
d2571775-6d47-4e70-b597-9a3de48a464c	true	id.token.claim
d2571775-6d47-4e70-b597-9a3de48a464c	true	access.token.claim
d2571775-6d47-4e70-b597-9a3de48a464c	nickname	claim.name
d2571775-6d47-4e70-b597-9a3de48a464c	String	jsonType.label
df8a7aaf-afe3-4589-9056-afe0c7debb64	true	userinfo.token.claim
df8a7aaf-afe3-4589-9056-afe0c7debb64	gender	user.attribute
df8a7aaf-afe3-4589-9056-afe0c7debb64	true	id.token.claim
df8a7aaf-afe3-4589-9056-afe0c7debb64	true	access.token.claim
df8a7aaf-afe3-4589-9056-afe0c7debb64	gender	claim.name
df8a7aaf-afe3-4589-9056-afe0c7debb64	String	jsonType.label
e21669de-2640-4a0f-a87e-e0911b470da2	true	userinfo.token.claim
e21669de-2640-4a0f-a87e-e0911b470da2	middleName	user.attribute
e21669de-2640-4a0f-a87e-e0911b470da2	true	id.token.claim
e21669de-2640-4a0f-a87e-e0911b470da2	true	access.token.claim
e21669de-2640-4a0f-a87e-e0911b470da2	middle_name	claim.name
e21669de-2640-4a0f-a87e-e0911b470da2	String	jsonType.label
e8fe9831-d658-466e-b143-dd31b00d01db	true	userinfo.token.claim
e8fe9831-d658-466e-b143-dd31b00d01db	profile	user.attribute
e8fe9831-d658-466e-b143-dd31b00d01db	true	id.token.claim
e8fe9831-d658-466e-b143-dd31b00d01db	true	access.token.claim
e8fe9831-d658-466e-b143-dd31b00d01db	profile	claim.name
e8fe9831-d658-466e-b143-dd31b00d01db	String	jsonType.label
7579d79d-3ac0-46b2-86f5-10c7087e902e	true	userinfo.token.claim
7579d79d-3ac0-46b2-86f5-10c7087e902e	email	user.attribute
7579d79d-3ac0-46b2-86f5-10c7087e902e	true	id.token.claim
7579d79d-3ac0-46b2-86f5-10c7087e902e	true	access.token.claim
7579d79d-3ac0-46b2-86f5-10c7087e902e	email	claim.name
7579d79d-3ac0-46b2-86f5-10c7087e902e	String	jsonType.label
843fd7ef-901b-47dc-a7f8-87a9c0f94ed8	true	userinfo.token.claim
843fd7ef-901b-47dc-a7f8-87a9c0f94ed8	emailVerified	user.attribute
843fd7ef-901b-47dc-a7f8-87a9c0f94ed8	true	id.token.claim
843fd7ef-901b-47dc-a7f8-87a9c0f94ed8	true	access.token.claim
843fd7ef-901b-47dc-a7f8-87a9c0f94ed8	email_verified	claim.name
843fd7ef-901b-47dc-a7f8-87a9c0f94ed8	boolean	jsonType.label
ceceb372-3e4e-427d-91f0-5f0396fff6a8	formatted	user.attribute.formatted
ceceb372-3e4e-427d-91f0-5f0396fff6a8	country	user.attribute.country
ceceb372-3e4e-427d-91f0-5f0396fff6a8	postal_code	user.attribute.postal_code
ceceb372-3e4e-427d-91f0-5f0396fff6a8	true	userinfo.token.claim
ceceb372-3e4e-427d-91f0-5f0396fff6a8	street	user.attribute.street
ceceb372-3e4e-427d-91f0-5f0396fff6a8	true	id.token.claim
ceceb372-3e4e-427d-91f0-5f0396fff6a8	region	user.attribute.region
ceceb372-3e4e-427d-91f0-5f0396fff6a8	true	access.token.claim
ceceb372-3e4e-427d-91f0-5f0396fff6a8	locality	user.attribute.locality
10816028-54e7-4ddf-a09b-dccf913a0420	true	userinfo.token.claim
10816028-54e7-4ddf-a09b-dccf913a0420	phoneNumberVerified	user.attribute
10816028-54e7-4ddf-a09b-dccf913a0420	true	id.token.claim
10816028-54e7-4ddf-a09b-dccf913a0420	true	access.token.claim
10816028-54e7-4ddf-a09b-dccf913a0420	phone_number_verified	claim.name
10816028-54e7-4ddf-a09b-dccf913a0420	boolean	jsonType.label
afc88ce5-2019-42cd-b9d4-d1a35ebe5783	true	userinfo.token.claim
afc88ce5-2019-42cd-b9d4-d1a35ebe5783	phoneNumber	user.attribute
afc88ce5-2019-42cd-b9d4-d1a35ebe5783	true	id.token.claim
afc88ce5-2019-42cd-b9d4-d1a35ebe5783	true	access.token.claim
afc88ce5-2019-42cd-b9d4-d1a35ebe5783	phone_number	claim.name
afc88ce5-2019-42cd-b9d4-d1a35ebe5783	String	jsonType.label
6398cb1d-ef01-42f4-a409-0f7c3629faa4	true	multivalued
6398cb1d-ef01-42f4-a409-0f7c3629faa4	foo	user.attribute
6398cb1d-ef01-42f4-a409-0f7c3629faa4	true	access.token.claim
6398cb1d-ef01-42f4-a409-0f7c3629faa4	resource_access.${client_id}.roles	claim.name
6398cb1d-ef01-42f4-a409-0f7c3629faa4	String	jsonType.label
f6fbb345-6ab1-488e-9de5-eb9248ec47d2	true	multivalued
f6fbb345-6ab1-488e-9de5-eb9248ec47d2	foo	user.attribute
f6fbb345-6ab1-488e-9de5-eb9248ec47d2	true	access.token.claim
f6fbb345-6ab1-488e-9de5-eb9248ec47d2	realm_access.roles	claim.name
f6fbb345-6ab1-488e-9de5-eb9248ec47d2	String	jsonType.label
77d43e4d-a362-473f-9d00-1298aab76142	true	userinfo.token.claim
77d43e4d-a362-473f-9d00-1298aab76142	username	user.attribute
77d43e4d-a362-473f-9d00-1298aab76142	true	id.token.claim
77d43e4d-a362-473f-9d00-1298aab76142	true	access.token.claim
77d43e4d-a362-473f-9d00-1298aab76142	upn	claim.name
77d43e4d-a362-473f-9d00-1298aab76142	String	jsonType.label
a49c4fe8-877a-4d56-9903-af71ec27fd33	true	multivalued
a49c4fe8-877a-4d56-9903-af71ec27fd33	foo	user.attribute
a49c4fe8-877a-4d56-9903-af71ec27fd33	true	id.token.claim
a49c4fe8-877a-4d56-9903-af71ec27fd33	true	access.token.claim
a49c4fe8-877a-4d56-9903-af71ec27fd33	groups	claim.name
a49c4fe8-877a-4d56-9903-af71ec27fd33	String	jsonType.label
3bf1426d-cf9a-49a4-99c0-3731b59f87cd	true	id.token.claim
3bf1426d-cf9a-49a4-99c0-3731b59f87cd	true	access.token.claim
5bc28e7a-ff7c-4d73-b41e-9f2f66fd7b33	true	userinfo.token.claim
5bc28e7a-ff7c-4d73-b41e-9f2f66fd7b33	locale	user.attribute
5bc28e7a-ff7c-4d73-b41e-9f2f66fd7b33	true	id.token.claim
5bc28e7a-ff7c-4d73-b41e-9f2f66fd7b33	true	access.token.claim
5bc28e7a-ff7c-4d73-b41e-9f2f66fd7b33	locale	claim.name
5bc28e7a-ff7c-4d73-b41e-9f2f66fd7b33	String	jsonType.label
6ffbb9ef-54ec-410f-9a2f-d347db7df6e4	groups	claim.name
6ffbb9ef-54ec-410f-9a2f-d347db7df6e4	false	full.path
6ffbb9ef-54ec-410f-9a2f-d347db7df6e4	true	id.token.claim
6ffbb9ef-54ec-410f-9a2f-d347db7df6e4	true	access.token.claim
6ffbb9ef-54ec-410f-9a2f-d347db7df6e4	true	userinfo.token.claim
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
912f0e36-c9a1-43b2-8a41-f3ef56854ae3	60	300	300	\N	\N	\N	t	f	0	\N	main	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	e250b166-3cba-4c76-994e-fb54ee85771b	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	a09e9105-c58e-45f0-b191-8590a43812e1	69dac60a-d530-459e-97bc-2d00bd8546bf	420314f2-27ba-443c-8021-dee85aaf9757	92c61584-2239-45e1-8bc4-b69740715f0c	033a85b9-98a5-479f-9b85-11276246a238	2592000	f	900	t	f	983b5ad1-f8e5-4707-9395-5c9bab75dde1	0	f	0	0	def4fa49-81ef-4ab9-98ec-95c599c738f2
e47c4261-2e1f-40a1-a6b0-9430a59b71fd	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	87cb64f7-838a-423f-bc1b-1fe934f609a8	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	cc1793bb-b836-4e16-b06b-ea1840b0b2e2	16836c02-fc4c-4f47-90eb-14e0a73884f1	256ebaa4-f0e3-4027-af03-6e8a9a1cc6fd	fea957fa-5886-45af-aaf5-22f124e3e865	68eaceab-b2b6-4929-a9d6-200c202d0dfc	2592000	f	900	t	f	2b0fb145-a609-48e8-b56a-d8f52f98c914	0	f	0	0	a262068b-d0e1-415e-96a2-ba6a73180eb1
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	
_browser_header.xContentTypeOptions	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	nosniff
_browser_header.xRobotsTag	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	none
_browser_header.xFrameOptions	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	SAMEORIGIN
_browser_header.contentSecurityPolicy	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	1; mode=block
_browser_header.strictTransportSecurity	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	max-age=31536000; includeSubDomains
bruteForceProtected	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	false
permanentLockout	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	false
maxFailureWaitSeconds	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	900
minimumQuickLoginWaitSeconds	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	60
waitIncrementSeconds	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	60
quickLoginCheckMilliSeconds	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	1000
maxDeltaTimeSeconds	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	43200
failureFactor	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	30
displayName	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	Keycloak
displayNameHtml	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	RS256
offlineSessionMaxLifespanEnabled	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	false
offlineSessionMaxLifespan	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	5184000
_browser_header.contentSecurityPolicyReportOnly	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	
_browser_header.xContentTypeOptions	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	nosniff
_browser_header.xRobotsTag	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	none
_browser_header.xFrameOptions	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	SAMEORIGIN
_browser_header.contentSecurityPolicy	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	1; mode=block
_browser_header.strictTransportSecurity	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	max-age=31536000; includeSubDomains
bruteForceProtected	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	false
permanentLockout	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	false
maxFailureWaitSeconds	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	900
minimumQuickLoginWaitSeconds	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	60
waitIncrementSeconds	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	60
quickLoginCheckMilliSeconds	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	1000
maxDeltaTimeSeconds	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	43200
failureFactor	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	30
defaultSignatureAlgorithm	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	RS256
offlineSessionMaxLifespanEnabled	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	false
offlineSessionMaxLifespan	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	5184000
actionTokenGeneratedByAdminLifespan	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	43200
actionTokenGeneratedByUserLifespan	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	300
oauth2DeviceCodeLifespan	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	600
oauth2DevicePollingInterval	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	5
webAuthnPolicyRpEntityName	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	keycloak
webAuthnPolicySignatureAlgorithms	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	ES256
webAuthnPolicyRpId	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	
webAuthnPolicyAttestationConveyancePreference	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	not specified
webAuthnPolicyAuthenticatorAttachment	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	not specified
webAuthnPolicyRequireResidentKey	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	not specified
webAuthnPolicyUserVerificationRequirement	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	not specified
webAuthnPolicyCreateTimeout	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	0
webAuthnPolicyAvoidSameAuthenticatorRegister	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	false
webAuthnPolicyRpEntityNamePasswordless	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	ES256
webAuthnPolicyRpIdPasswordless	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	
webAuthnPolicyAttestationConveyancePreferencePasswordless	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	not specified
webAuthnPolicyRequireResidentKeyPasswordless	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	not specified
webAuthnPolicyCreateTimeoutPasswordless	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	false
cibaBackchannelTokenDeliveryMode	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	poll
cibaExpiresIn	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	120
cibaInterval	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	5
cibaAuthRequestedUserHint	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	login_hint
parRequestUriLifespan	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	60
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
e47c4261-2e1f-40a1-a6b0-9430a59b71fd	jboss-logging
912f0e36-c9a1-43b2-8a41-f3ef56854ae3	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	e47c4261-2e1f-40a1-a6b0-9430a59b71fd
password	password	t	t	912f0e36-c9a1-43b2-8a41-f3ef56854ae3
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.redirect_uris (client_id, value) FROM stdin;
a4b9d5b4-4506-46bd-9fae-97d61da1b553	/realms/master/account/*
67e37d4b-6f6f-43ff-b761-e3692dca9c05	/realms/master/account/*
ddd67d36-1bb3-4ad3-bb85-07934e174e09	/admin/master/console/*
d15f4ea4-a056-439d-8eac-ea5743e8693a	/realms/main/account/*
854ef916-6fc8-4da4-a6ca-a1a0ac16cd66	/admin/main/console/*
fbd356ac-40ee-470f-a677-7158e3c3c401	/realms/main/account/*
84ebb1c4-7bf6-4b95-a8d9-b7980f700484	http://argocd.kube.local/auth/callback
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
5abc977a-36fd-4e1d-9990-6748abcaf31e	VERIFY_EMAIL	Verify Email	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	t	f	VERIFY_EMAIL	50
509b9178-5db0-4185-a976-7531c0792170	UPDATE_PROFILE	Update Profile	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	t	f	UPDATE_PROFILE	40
626def2e-ff75-4df8-afc7-ea5e5f277e90	CONFIGURE_TOTP	Configure OTP	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	t	f	CONFIGURE_TOTP	10
573ea401-118c-4625-83ee-7241fdba0ccb	UPDATE_PASSWORD	Update Password	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	t	f	UPDATE_PASSWORD	30
80b02037-520b-477e-b654-283071d39468	terms_and_conditions	Terms and Conditions	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	f	f	terms_and_conditions	20
88cba5cb-d8a8-4b0b-8155-d161aa896178	update_user_locale	Update User Locale	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	t	f	update_user_locale	1000
5ab31677-c84c-4636-9372-480f513a9022	delete_account	Delete Account	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	f	f	delete_account	60
d1ef5e34-4f92-4e88-8c07-9d7f3e189c68	webauthn-register	Webauthn Register	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	t	f	webauthn-register	70
ab1af07f-ef7c-4ef8-a680-f9f05b62a8f1	webauthn-register-passwordless	Webauthn Register Passwordless	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	t	f	webauthn-register-passwordless	80
26d80a9b-aac2-4846-92e4-e49c6e6a626c	VERIFY_EMAIL	Verify Email	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	t	f	VERIFY_EMAIL	50
a67758c0-986a-438b-a18b-32f3167347d5	UPDATE_PROFILE	Update Profile	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	t	f	UPDATE_PROFILE	40
2421c8a4-6beb-44cd-8295-14929fc8b870	CONFIGURE_TOTP	Configure OTP	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	t	f	CONFIGURE_TOTP	10
d9666f55-2d63-4d5a-9604-31308e830c13	UPDATE_PASSWORD	Update Password	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	t	f	UPDATE_PASSWORD	30
b9c23b5c-4582-48b0-b671-4a7b7d0ac709	terms_and_conditions	Terms and Conditions	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	f	f	terms_and_conditions	20
d3f33f1c-5084-415d-8177-3cf9bdc5a3e3	update_user_locale	Update User Locale	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	t	f	update_user_locale	1000
735eb78c-6674-47fb-b493-9d64a7522ef1	delete_account	Delete Account	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	f	f	delete_account	60
c825315c-7e75-4bdf-beaf-7ff98e23e4e4	webauthn-register	Webauthn Register	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	t	f	webauthn-register	70
d8d58fd2-34b7-4a5b-8f4a-a3125bf25a9f	webauthn-register-passwordless	Webauthn Register Passwordless	912f0e36-c9a1-43b2-8a41-f3ef56854ae3	t	f	webauthn-register-passwordless	80
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_uris (resource_id, value) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
67e37d4b-6f6f-43ff-b761-e3692dca9c05	654969e7-5e26-4b96-b55e-fce2dc2b7e7e
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_attribute (name, value, user_id, id) FROM stdin;
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
2bac2a87-2459-4520-b8d5-2a6ce297f99d	\N	585280f2-0afe-4abd-abe5-56f2766c00cc	f	t	\N	\N	\N	e47c4261-2e1f-40a1-a6b0-9430a59b71fd	admin	1664561654089	\N	0
36b0f7be-6a1b-4a83-bd29-496f2d42e8fc	admin@admin.com	admin@admin.com	t	t	\N			912f0e36-c9a1-43b2-8a41-f3ef56854ae3	admin	1664884706152	\N	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_group_membership (group_id, user_id) FROM stdin;
de1ffa6c-ca11-4589-8cfd-ec67d0481c61	36b0f7be-6a1b-4a83-bd29-496f2d42e8fc
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
a262068b-d0e1-415e-96a2-ba6a73180eb1	2bac2a87-2459-4520-b8d5-2a6ce297f99d
b872bf24-9567-43b8-b17f-8a0c8b9d480a	2bac2a87-2459-4520-b8d5-2a6ce297f99d
4aca9eb3-6030-49d7-b5ab-4cd1ec91d21a	2bac2a87-2459-4520-b8d5-2a6ce297f99d
646ef6d2-0354-4585-aead-8ed91fff8534	2bac2a87-2459-4520-b8d5-2a6ce297f99d
bf1a9ddf-23b3-47ba-90f4-1ed2659a3471	2bac2a87-2459-4520-b8d5-2a6ce297f99d
c6cfbe04-0471-49e4-a569-cd4150ff7c8e	2bac2a87-2459-4520-b8d5-2a6ce297f99d
de1cced5-43fd-4334-965e-5929fc2eed87	2bac2a87-2459-4520-b8d5-2a6ce297f99d
fdd868da-74ee-446c-97ce-eaf3e96c6687	2bac2a87-2459-4520-b8d5-2a6ce297f99d
57889376-837a-4ca3-97a5-56ff0bd19c02	2bac2a87-2459-4520-b8d5-2a6ce297f99d
8c29e340-4cd2-4d81-8429-62c878efbf69	2bac2a87-2459-4520-b8d5-2a6ce297f99d
05a26056-a4ac-4521-b25b-4e9748e9915a	2bac2a87-2459-4520-b8d5-2a6ce297f99d
11ce42e6-bd6d-472e-8c85-bc106480e710	2bac2a87-2459-4520-b8d5-2a6ce297f99d
6c34b098-d27c-4e49-bb82-6eeb7998e6c9	2bac2a87-2459-4520-b8d5-2a6ce297f99d
c01d8979-3356-478f-98a5-2bc24387e624	2bac2a87-2459-4520-b8d5-2a6ce297f99d
757c0431-8cf5-4276-8db2-00d4b659dec4	2bac2a87-2459-4520-b8d5-2a6ce297f99d
044ab6cd-2427-4bd7-9d6c-7b950a63cb4f	2bac2a87-2459-4520-b8d5-2a6ce297f99d
ab21d099-4d59-4521-beb2-51eff11e53ba	2bac2a87-2459-4520-b8d5-2a6ce297f99d
34d0083f-cdd4-4ab5-af31-7c8aa873eea3	2bac2a87-2459-4520-b8d5-2a6ce297f99d
f2284e81-8447-4ba6-b706-3c35de78af89	2bac2a87-2459-4520-b8d5-2a6ce297f99d
def4fa49-81ef-4ab9-98ec-95c599c738f2	36b0f7be-6a1b-4a83-bd29-496f2d42e8fc
\.


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.web_origins (client_id, value) FROM stdin;
ddd67d36-1bb3-4ad3-bb85-07934e174e09	+
854ef916-6fc8-4da4-a6ca-a1a0ac16cd66	+
84ebb1c4-7bf6-4b95-a8d9-b7980f700484	http://argocd.kube.local
\.


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: idx_admin_event_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_admin_event_time ON public.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_css_preload; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_css_preload ON public.offline_client_session USING btree (client_id, offline_flag);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_offline_uss_by_usersess; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_by_usersess ON public.offline_user_session USING btree (realm_id, offline_flag, user_session_id);


--
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_createdon ON public.offline_user_session USING btree (created_on);


--
-- Name: idx_offline_uss_preload; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_preload ON public.offline_user_session USING btree (offline_flag, created_on, user_session_id);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_user_service_account; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_service_account ON public.user_entity USING btree (realm_id, service_account_client_link);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

\connect postgres

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 10.21 (Debian 10.21-1.pgdg90+1)
-- Dumped by pg_dump version 10.21 (Debian 10.21-1.pgdg90+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- PostgreSQL database dump complete
--

\connect template1

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 10.21 (Debian 10.21-1.pgdg90+1)
-- Dumped by pg_dump version 10.21 (Debian 10.21-1.pgdg90+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE template1; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE template1 IS 'default template for new databases';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

