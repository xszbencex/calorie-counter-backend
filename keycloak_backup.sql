--
-- PostgreSQL database dump
--

-- Dumped from database version 14.2 (Debian 14.2-1.pgdg110+1)
-- Dumped by pg_dump version 14.2

-- Started on 2022-03-15 14:50:19

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
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 4216 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 210 (class 1259 OID 42667)
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
-- TOC entry 211 (class 1259 OID 42672)
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 42675)
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
-- TOC entry 213 (class 1259 OID 42679)
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
-- TOC entry 214 (class 1259 OID 42687)
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 42690)
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 42695)
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
-- TOC entry 217 (class 1259 OID 42700)
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
-- TOC entry 218 (class 1259 OID 42718)
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    value character varying(4000),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_attributes OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 42723)
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 42726)
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
-- TOC entry 221 (class 1259 OID 42729)
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 42732)
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
-- TOC entry 223 (class 1259 OID 42737)
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 42742)
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 42748)
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 42751)
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
-- TOC entry 227 (class 1259 OID 42756)
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_auth_status OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 42759)
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_note OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 42764)
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_prot_mapper OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 42767)
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_role OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 42770)
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_user_session_note OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 42775)
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
-- TOC entry 233 (class 1259 OID 42780)
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
-- TOC entry 234 (class 1259 OID 42785)
-- Name: composite_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 42788)
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
-- TOC entry 236 (class 1259 OID 42793)
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
-- TOC entry 237 (class 1259 OID 42798)
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
-- TOC entry 238 (class 1259 OID 42801)
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 42805)
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
-- TOC entry 240 (class 1259 OID 42810)
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
-- TOC entry 241 (class 1259 OID 42815)
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
-- TOC entry 242 (class 1259 OID 42820)
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 42823)
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
-- TOC entry 244 (class 1259 OID 42828)
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
-- TOC entry 245 (class 1259 OID 42831)
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
-- TOC entry 246 (class 1259 OID 42837)
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
-- TOC entry 247 (class 1259 OID 42840)
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
-- TOC entry 248 (class 1259 OID 42845)
-- Name: federated_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 42850)
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
-- TOC entry 250 (class 1259 OID 42856)
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 42859)
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
-- TOC entry 252 (class 1259 OID 42870)
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 42875)
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
-- TOC entry 254 (class 1259 OID 42880)
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 42885)
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
-- TOC entry 256 (class 1259 OID 42888)
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
-- TOC entry 257 (class 1259 OID 42894)
-- Name: migration_model; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO postgres;

--
-- TOC entry 258 (class 1259 OID 42898)
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
-- TOC entry 259 (class 1259 OID 42905)
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
-- TOC entry 260 (class 1259 OID 42911)
-- Name: policy_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO postgres;

--
-- TOC entry 261 (class 1259 OID 42916)
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
-- TOC entry 262 (class 1259 OID 42921)
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO postgres;

--
-- TOC entry 263 (class 1259 OID 42926)
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
-- TOC entry 264 (class 1259 OID 42959)
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO postgres;

--
-- TOC entry 265 (class 1259 OID 42964)
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO postgres;

--
-- TOC entry 266 (class 1259 OID 42967)
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO postgres;

--
-- TOC entry 267 (class 1259 OID 42970)
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO postgres;

--
-- TOC entry 268 (class 1259 OID 42973)
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO postgres;

--
-- TOC entry 269 (class 1259 OID 42978)
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
-- TOC entry 270 (class 1259 OID 42985)
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO postgres;

--
-- TOC entry 271 (class 1259 OID 42990)
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO postgres;

--
-- TOC entry 272 (class 1259 OID 42993)
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO postgres;

--
-- TOC entry 273 (class 1259 OID 42996)
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO postgres;

--
-- TOC entry 274 (class 1259 OID 43001)
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
-- TOC entry 275 (class 1259 OID 43008)
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
-- TOC entry 276 (class 1259 OID 43014)
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO postgres;

--
-- TOC entry 277 (class 1259 OID 43017)
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO postgres;

--
-- TOC entry 278 (class 1259 OID 43020)
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
-- TOC entry 279 (class 1259 OID 43025)
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
-- TOC entry 280 (class 1259 OID 43030)
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
-- TOC entry 281 (class 1259 OID 43035)
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
-- TOC entry 282 (class 1259 OID 43041)
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
-- TOC entry 283 (class 1259 OID 43046)
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO postgres;

--
-- TOC entry 284 (class 1259 OID 43049)
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
-- TOC entry 285 (class 1259 OID 43054)
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO postgres;

--
-- TOC entry 286 (class 1259 OID 43057)
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO postgres;

--
-- TOC entry 287 (class 1259 OID 43060)
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
-- TOC entry 288 (class 1259 OID 43066)
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
-- TOC entry 289 (class 1259 OID 43071)
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO postgres;

--
-- TOC entry 290 (class 1259 OID 43074)
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
-- TOC entry 291 (class 1259 OID 43082)
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO postgres;

--
-- TOC entry 292 (class 1259 OID 43087)
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
-- TOC entry 293 (class 1259 OID 43092)
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO postgres;

--
-- TOC entry 294 (class 1259 OID 43097)
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
-- TOC entry 295 (class 1259 OID 43102)
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO postgres;

--
-- TOC entry 296 (class 1259 OID 43105)
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO postgres;

--
-- TOC entry 297 (class 1259 OID 43109)
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO postgres;

--
-- TOC entry 298 (class 1259 OID 43112)
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
-- TOC entry 299 (class 1259 OID 43118)
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE public.user_session_note OWNER TO postgres;

--
-- TOC entry 300 (class 1259 OID 43123)
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
-- TOC entry 301 (class 1259 OID 43128)
-- Name: web_origins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO postgres;

--
-- TOC entry 4119 (class 0 OID 42667)
-- Dependencies: 210
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- TOC entry 4120 (class 0 OID 42672)
-- Dependencies: 211
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- TOC entry 4121 (class 0 OID 42675)
-- Dependencies: 212
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
139c08c6-6a0b-4c40-932f-009210c6fa00	\N	auth-cookie	master	b26d517f-fe54-4ef2-9f85-e802b27b5074	2	10	f	\N	\N
80508e52-83bb-4c52-b722-0fbb21b2b6ef	\N	auth-spnego	master	b26d517f-fe54-4ef2-9f85-e802b27b5074	3	20	f	\N	\N
2145ce1e-993d-42d7-9839-99f066357d46	\N	identity-provider-redirector	master	b26d517f-fe54-4ef2-9f85-e802b27b5074	2	25	f	\N	\N
5e720d17-2e74-4286-ac0b-1ffeba863bdb	\N	\N	master	b26d517f-fe54-4ef2-9f85-e802b27b5074	2	30	t	f1565d7a-7074-4c5a-90d6-671d95a7c40a	\N
455259e4-9fd8-4999-9675-b39bd1134c93	\N	auth-username-password-form	master	f1565d7a-7074-4c5a-90d6-671d95a7c40a	0	10	f	\N	\N
057fd076-0caa-4bc0-bc09-d9de111022b7	\N	\N	master	f1565d7a-7074-4c5a-90d6-671d95a7c40a	1	20	t	75bda683-7014-45e7-a2a5-6cfe80042558	\N
23142e35-d9b4-4488-9bb4-56481697208e	\N	conditional-user-configured	master	75bda683-7014-45e7-a2a5-6cfe80042558	0	10	f	\N	\N
cdda5feb-9552-469b-8e6a-8ac9843bf9f2	\N	auth-otp-form	master	75bda683-7014-45e7-a2a5-6cfe80042558	0	20	f	\N	\N
e6431a82-0cd9-466d-8776-88d845aeb738	\N	direct-grant-validate-username	master	52418229-2554-4b7d-8b4e-799635d9ed7b	0	10	f	\N	\N
93bc55fd-863d-47ad-a52f-27096a9a4ca3	\N	direct-grant-validate-password	master	52418229-2554-4b7d-8b4e-799635d9ed7b	0	20	f	\N	\N
a3c43303-eaee-4cb1-b670-a8bceb313839	\N	\N	master	52418229-2554-4b7d-8b4e-799635d9ed7b	1	30	t	d32f96bd-4bd9-46d1-98cc-734e3e341678	\N
fe56695b-af16-440a-b5ac-6cb50c4503c4	\N	conditional-user-configured	master	d32f96bd-4bd9-46d1-98cc-734e3e341678	0	10	f	\N	\N
10393ae2-257f-49b9-8fe6-be80cc1f015a	\N	direct-grant-validate-otp	master	d32f96bd-4bd9-46d1-98cc-734e3e341678	0	20	f	\N	\N
cd9fbea1-ef31-4d1f-97a6-8bf706856dba	\N	registration-page-form	master	23d319c4-c287-407b-a86b-e3cc4c11ef4e	0	10	t	4450e78e-9304-4188-b485-208776e4419b	\N
413befc4-d670-47d8-9081-9779d3247a78	\N	registration-user-creation	master	4450e78e-9304-4188-b485-208776e4419b	0	20	f	\N	\N
242c3336-6eed-4888-9a7e-7c37b38ba126	\N	registration-profile-action	master	4450e78e-9304-4188-b485-208776e4419b	0	40	f	\N	\N
3a78b84c-dc1a-403c-928a-e54ac2273bf5	\N	registration-password-action	master	4450e78e-9304-4188-b485-208776e4419b	0	50	f	\N	\N
8b59ae87-b771-492d-92c5-d303f299de3b	\N	registration-recaptcha-action	master	4450e78e-9304-4188-b485-208776e4419b	3	60	f	\N	\N
b77b5735-1847-4e17-9ebd-5e2d6ebb740a	\N	reset-credentials-choose-user	master	b8105554-1902-4f9b-b81f-24b9afa98258	0	10	f	\N	\N
5326ba5a-0cdb-4eb9-86f9-0f30bdfcfc56	\N	reset-credential-email	master	b8105554-1902-4f9b-b81f-24b9afa98258	0	20	f	\N	\N
163060dc-e3fd-4e16-a114-8f002329b208	\N	reset-password	master	b8105554-1902-4f9b-b81f-24b9afa98258	0	30	f	\N	\N
cbe9297b-10f0-455e-80dc-98095c28e6c6	\N	\N	master	b8105554-1902-4f9b-b81f-24b9afa98258	1	40	t	a6b35da8-497b-4036-a94d-ccb2e99ca956	\N
b78542a2-8d0c-4a01-80c3-819df7b71663	\N	conditional-user-configured	master	a6b35da8-497b-4036-a94d-ccb2e99ca956	0	10	f	\N	\N
cf9a63a3-21f2-41c7-a994-33721d2164a3	\N	reset-otp	master	a6b35da8-497b-4036-a94d-ccb2e99ca956	0	20	f	\N	\N
81a832b0-0ea8-47ae-8e5b-55c1cdbe0791	\N	client-secret	master	e9567cb7-01f7-4a2c-929a-3f33908f2254	2	10	f	\N	\N
b5ab3869-1043-4748-86df-6871deb91adf	\N	client-jwt	master	e9567cb7-01f7-4a2c-929a-3f33908f2254	2	20	f	\N	\N
b435298c-880c-40bf-9f9b-8802af56d33e	\N	client-secret-jwt	master	e9567cb7-01f7-4a2c-929a-3f33908f2254	2	30	f	\N	\N
115b1ed6-43fc-4a1d-937b-52b1bac657f9	\N	client-x509	master	e9567cb7-01f7-4a2c-929a-3f33908f2254	2	40	f	\N	\N
3ef17c83-084e-4239-b210-1f3771214de2	\N	idp-review-profile	master	0b0976e5-9be3-4c9c-875c-ff5558a53697	0	10	f	\N	3e966fe1-1409-4d83-a21c-1b9635283935
c0a4c0f6-0de2-4ea7-8af7-98ea03a3d360	\N	\N	master	0b0976e5-9be3-4c9c-875c-ff5558a53697	0	20	t	6b786101-315c-4f57-af96-481f63bf8175	\N
1ecced12-a802-40f3-94d3-a7accbccafe2	\N	idp-create-user-if-unique	master	6b786101-315c-4f57-af96-481f63bf8175	2	10	f	\N	6e77f69c-05fc-40fc-8fef-984168a93bfe
79349ea8-b434-4108-a11a-96118ae300e7	\N	\N	master	6b786101-315c-4f57-af96-481f63bf8175	2	20	t	aa1ec1c8-25b7-49b7-a2f8-f231fa54bc2e	\N
3bad3639-8494-46fd-8ae1-db12902788db	\N	idp-confirm-link	master	aa1ec1c8-25b7-49b7-a2f8-f231fa54bc2e	0	10	f	\N	\N
9910d97b-d9f9-4a1f-a3e8-a3a057ee81ce	\N	\N	master	aa1ec1c8-25b7-49b7-a2f8-f231fa54bc2e	0	20	t	20f7c4ab-a107-4911-ad4f-3b92ac2d1e95	\N
3e35ba14-307a-4a18-9100-ab687ec25bb0	\N	idp-email-verification	master	20f7c4ab-a107-4911-ad4f-3b92ac2d1e95	2	10	f	\N	\N
714d1ffe-e328-46fd-989e-b31784b3cf99	\N	\N	master	20f7c4ab-a107-4911-ad4f-3b92ac2d1e95	2	20	t	83bac3f4-bc7c-4e4d-9e43-fee6c0172297	\N
a08f819b-da09-4189-b09d-63a0a023655e	\N	idp-username-password-form	master	83bac3f4-bc7c-4e4d-9e43-fee6c0172297	0	10	f	\N	\N
c93b4f67-7127-4f7f-9b03-53f68080997a	\N	\N	master	83bac3f4-bc7c-4e4d-9e43-fee6c0172297	1	20	t	954e478b-3eb7-4243-86ba-d7746a8e642a	\N
3e39210d-21ef-4f80-bc43-f7519bc4880e	\N	conditional-user-configured	master	954e478b-3eb7-4243-86ba-d7746a8e642a	0	10	f	\N	\N
7b36b03d-808e-44eb-8980-0c0634e0061f	\N	auth-otp-form	master	954e478b-3eb7-4243-86ba-d7746a8e642a	0	20	f	\N	\N
612d0d60-3492-49e6-9a36-a58d40be5ff0	\N	http-basic-authenticator	master	5a0767ce-256e-433a-ac05-a3e2a60c5d3b	0	10	f	\N	\N
592ac0a1-374a-4d94-bc49-8bfc62f5c9d6	\N	docker-http-basic-authenticator	master	079b613e-85ee-4499-ba03-937467d0aa0e	0	10	f	\N	\N
4f78a36f-2c9d-4fb5-bda8-0f96e26f5221	\N	no-cookie-redirect	master	09b51924-679d-4100-b666-51fb2c21289a	0	10	f	\N	\N
c71f2727-dae1-40cb-8582-575aeea6236c	\N	\N	master	09b51924-679d-4100-b666-51fb2c21289a	0	20	t	c471afc3-1714-4397-a420-e97aa377a572	\N
938cc97c-2169-4eff-9ee4-b43fc103ede3	\N	basic-auth	master	c471afc3-1714-4397-a420-e97aa377a572	0	10	f	\N	\N
eda57371-3a0f-4fb8-8e58-5639124aac41	\N	basic-auth-otp	master	c471afc3-1714-4397-a420-e97aa377a572	3	20	f	\N	\N
7fee7e3b-a86e-4a16-ac09-874c4137796a	\N	auth-spnego	master	c471afc3-1714-4397-a420-e97aa377a572	3	30	f	\N	\N
886b3e61-a11e-491d-bf77-bef311d51b09	\N	idp-email-verification	CC	92de6ba5-d3ff-4d10-89cb-c178b84236e1	2	10	f	\N	\N
bffc6d50-ba5a-471c-b02e-ee297ac0754d	\N	\N	CC	92de6ba5-d3ff-4d10-89cb-c178b84236e1	2	20	t	a72dfa99-efb7-466a-81a7-f27e0b4df010	\N
f98030f9-59f0-41c9-86cf-3e4e76eec373	\N	basic-auth	CC	1aa88ddb-2e10-4dad-9e7b-fe91f346d737	0	10	f	\N	\N
8a86c7b4-221b-4c35-964d-63cb2832aef8	\N	basic-auth-otp	CC	1aa88ddb-2e10-4dad-9e7b-fe91f346d737	3	20	f	\N	\N
97716ca7-4bb6-48dc-8f0e-8e7b0535223d	\N	auth-spnego	CC	1aa88ddb-2e10-4dad-9e7b-fe91f346d737	3	30	f	\N	\N
dacbcadb-dee6-4aef-8893-408c5151487a	\N	conditional-user-configured	CC	86f11be9-8679-4bcf-82d1-eb9c021311b0	0	10	f	\N	\N
d91db3a4-c319-4635-a320-e3ae45501a30	\N	auth-otp-form	CC	86f11be9-8679-4bcf-82d1-eb9c021311b0	0	20	f	\N	\N
b77bc05e-732b-429d-9269-083f5329e311	\N	conditional-user-configured	CC	9207b014-944a-486a-8a0d-b3ccc4de4404	0	10	f	\N	\N
fa63b04d-f480-44ee-a8b4-1b82d66b2af9	\N	direct-grant-validate-otp	CC	9207b014-944a-486a-8a0d-b3ccc4de4404	0	20	f	\N	\N
dd756aa4-434c-4695-aaf3-d55b15bf55d0	\N	conditional-user-configured	CC	90aa0e87-cb07-4f94-b227-7dd00d1648e0	0	10	f	\N	\N
2458dcaa-d476-46e9-93d8-0dabd7ab02af	\N	auth-otp-form	CC	90aa0e87-cb07-4f94-b227-7dd00d1648e0	0	20	f	\N	\N
ecc26264-1eec-4685-bba5-3dcc47f6cc9a	\N	idp-confirm-link	CC	f3c144f6-5a85-428f-ab82-daa91e159da8	0	10	f	\N	\N
c28f10d0-b09c-474a-b25e-5f8e8daeded4	\N	\N	CC	f3c144f6-5a85-428f-ab82-daa91e159da8	0	20	t	92de6ba5-d3ff-4d10-89cb-c178b84236e1	\N
0e215321-71cd-4de5-8e92-3a702292bd09	\N	conditional-user-configured	CC	b2150b2f-5af0-4fcd-84b3-7c376f29db75	0	10	f	\N	\N
0b4b1077-6b1b-4cbc-b2df-1dce2ae99fb4	\N	reset-otp	CC	b2150b2f-5af0-4fcd-84b3-7c376f29db75	0	20	f	\N	\N
6c705b11-257d-4376-8f15-bd6f50353bd3	\N	idp-create-user-if-unique	CC	1650b4a9-4056-4d05-b99b-564491ae6107	2	10	f	\N	5672748a-00db-4aa0-8b2a-f8490c7c894c
89c88263-1e4a-4056-8020-13f9988f93b9	\N	\N	CC	1650b4a9-4056-4d05-b99b-564491ae6107	2	20	t	f3c144f6-5a85-428f-ab82-daa91e159da8	\N
ca07427c-752c-485e-a098-04113902fb25	\N	idp-username-password-form	CC	a72dfa99-efb7-466a-81a7-f27e0b4df010	0	10	f	\N	\N
08c93f4c-e628-4928-93d9-1482a8728578	\N	\N	CC	a72dfa99-efb7-466a-81a7-f27e0b4df010	1	20	t	90aa0e87-cb07-4f94-b227-7dd00d1648e0	\N
ac384ba2-01e3-44f8-b40a-afa329682274	\N	auth-cookie	CC	6e85640d-e6c3-4b48-a8b9-12528e369bbd	2	10	f	\N	\N
99c5c4eb-b54f-4315-a435-13efc3e48f16	\N	auth-spnego	CC	6e85640d-e6c3-4b48-a8b9-12528e369bbd	3	20	f	\N	\N
f850c6d4-d2cb-471e-b69f-df1eaedc8633	\N	identity-provider-redirector	CC	6e85640d-e6c3-4b48-a8b9-12528e369bbd	2	25	f	\N	\N
4b1c631b-235d-4836-99a6-1668d02de584	\N	\N	CC	6e85640d-e6c3-4b48-a8b9-12528e369bbd	2	30	t	e081681c-4169-4c3f-b05c-cf0d63b09e44	\N
9783ab69-0307-4a41-bed8-72f1d8b0d9f6	\N	client-secret	CC	8a3d4c9a-f3c6-49c1-a932-625a993fa21e	2	10	f	\N	\N
0f1379ea-9cf0-4225-9f3a-8bff1cfa0086	\N	client-jwt	CC	8a3d4c9a-f3c6-49c1-a932-625a993fa21e	2	20	f	\N	\N
6058d7f8-8cf0-45f4-9644-152c0b363b0d	\N	client-secret-jwt	CC	8a3d4c9a-f3c6-49c1-a932-625a993fa21e	2	30	f	\N	\N
dfe03218-6ac0-492b-8802-93f112ce61d1	\N	client-x509	CC	8a3d4c9a-f3c6-49c1-a932-625a993fa21e	2	40	f	\N	\N
b73c4693-e249-41c2-bfb0-3229dd788b51	\N	direct-grant-validate-username	CC	1fdd1aef-9038-4dc3-ac05-bb746a360392	0	10	f	\N	\N
8e0cd290-2732-4051-9b9a-9f2d232110f2	\N	direct-grant-validate-password	CC	1fdd1aef-9038-4dc3-ac05-bb746a360392	0	20	f	\N	\N
23fdcb92-6308-409d-b8a9-16ddef1beaee	\N	\N	CC	1fdd1aef-9038-4dc3-ac05-bb746a360392	1	30	t	9207b014-944a-486a-8a0d-b3ccc4de4404	\N
f67f8b50-02c8-4516-bafe-36e745116b55	\N	docker-http-basic-authenticator	CC	a03fdfa5-3a9e-463e-a442-eaa822da1ee5	0	10	f	\N	\N
088a0869-c202-4c08-a973-a9a2b7a8b290	\N	idp-review-profile	CC	e6aec560-8814-4813-9c1b-5169e1142449	0	10	f	\N	18125f15-9c23-4998-90bf-d27ecdcb9cd4
8bb7331d-dbc7-46df-9721-54d40db546ea	\N	\N	CC	e6aec560-8814-4813-9c1b-5169e1142449	0	20	t	1650b4a9-4056-4d05-b99b-564491ae6107	\N
0657dbc2-e7ac-4452-b925-abe78c3a4e31	\N	auth-username-password-form	CC	e081681c-4169-4c3f-b05c-cf0d63b09e44	0	10	f	\N	\N
5af3f22b-6f19-4c45-a3ac-8eed9809fdb5	\N	\N	CC	e081681c-4169-4c3f-b05c-cf0d63b09e44	1	20	t	86f11be9-8679-4bcf-82d1-eb9c021311b0	\N
e710c348-8e8c-4d00-bc3c-23ffb065e926	\N	no-cookie-redirect	CC	85f8b6ca-5309-4187-bbf0-56dc4b19fbb8	0	10	f	\N	\N
d71e89f8-5a73-4bb4-ab4c-bc463f2572a8	\N	\N	CC	85f8b6ca-5309-4187-bbf0-56dc4b19fbb8	0	20	t	1aa88ddb-2e10-4dad-9e7b-fe91f346d737	\N
a385aedd-6feb-4fe7-b243-b6b730cbf54e	\N	registration-page-form	CC	1f7c329f-80fa-47f9-bf22-b0fb3fd3333b	0	10	t	1feec0fb-d71e-431d-b1ef-2f2d44aa32a2	\N
f15753fb-077f-41e2-8381-c0998465ae0b	\N	registration-user-creation	CC	1feec0fb-d71e-431d-b1ef-2f2d44aa32a2	0	20	f	\N	\N
3961ecc9-2c5c-44e7-8efa-335350f5abf8	\N	registration-profile-action	CC	1feec0fb-d71e-431d-b1ef-2f2d44aa32a2	0	40	f	\N	\N
8b62ea6b-5846-4e69-b6ee-1456d231c0ae	\N	registration-password-action	CC	1feec0fb-d71e-431d-b1ef-2f2d44aa32a2	0	50	f	\N	\N
54664f02-8584-43e9-9694-06ae572ec32e	\N	registration-recaptcha-action	CC	1feec0fb-d71e-431d-b1ef-2f2d44aa32a2	3	60	f	\N	\N
cbf9d2dc-738e-4224-8856-677fe48e6511	\N	reset-credentials-choose-user	CC	d52d288b-a24c-426c-9f10-5046c43f4e7f	0	10	f	\N	\N
e4f24e7c-c449-445d-9bba-7b960a665fe8	\N	reset-credential-email	CC	d52d288b-a24c-426c-9f10-5046c43f4e7f	0	20	f	\N	\N
91099794-1f6f-4745-87f6-c48340297b28	\N	reset-password	CC	d52d288b-a24c-426c-9f10-5046c43f4e7f	0	30	f	\N	\N
eeb6849b-f788-4783-ae49-304810eddf73	\N	\N	CC	d52d288b-a24c-426c-9f10-5046c43f4e7f	1	40	t	b2150b2f-5af0-4fcd-84b3-7c376f29db75	\N
6f48ebc7-434b-4341-89b4-8adedffa05ac	\N	http-basic-authenticator	CC	ea812e2e-420a-4535-9416-22efea6dc7fb	0	10	f	\N	\N
\.


--
-- TOC entry 4122 (class 0 OID 42679)
-- Dependencies: 213
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
b26d517f-fe54-4ef2-9f85-e802b27b5074	browser	browser based authentication	master	basic-flow	t	t
f1565d7a-7074-4c5a-90d6-671d95a7c40a	forms	Username, password, otp and other auth forms.	master	basic-flow	f	t
75bda683-7014-45e7-a2a5-6cfe80042558	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
52418229-2554-4b7d-8b4e-799635d9ed7b	direct grant	OpenID Connect Resource Owner Grant	master	basic-flow	t	t
d32f96bd-4bd9-46d1-98cc-734e3e341678	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
23d319c4-c287-407b-a86b-e3cc4c11ef4e	registration	registration flow	master	basic-flow	t	t
4450e78e-9304-4188-b485-208776e4419b	registration form	registration form	master	form-flow	f	t
b8105554-1902-4f9b-b81f-24b9afa98258	reset credentials	Reset credentials for a user if they forgot their password or something	master	basic-flow	t	t
a6b35da8-497b-4036-a94d-ccb2e99ca956	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	master	basic-flow	f	t
e9567cb7-01f7-4a2c-929a-3f33908f2254	clients	Base authentication for clients	master	client-flow	t	t
0b0976e5-9be3-4c9c-875c-ff5558a53697	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	master	basic-flow	t	t
6b786101-315c-4f57-af96-481f63bf8175	User creation or linking	Flow for the existing/non-existing user alternatives	master	basic-flow	f	t
aa1ec1c8-25b7-49b7-a2f8-f231fa54bc2e	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	master	basic-flow	f	t
20f7c4ab-a107-4911-ad4f-3b92ac2d1e95	Account verification options	Method with which to verity the existing account	master	basic-flow	f	t
83bac3f4-bc7c-4e4d-9e43-fee6c0172297	Verify Existing Account by Re-authentication	Reauthentication of existing account	master	basic-flow	f	t
954e478b-3eb7-4243-86ba-d7746a8e642a	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
5a0767ce-256e-433a-ac05-a3e2a60c5d3b	saml ecp	SAML ECP Profile Authentication Flow	master	basic-flow	t	t
079b613e-85ee-4499-ba03-937467d0aa0e	docker auth	Used by Docker clients to authenticate against the IDP	master	basic-flow	t	t
09b51924-679d-4100-b666-51fb2c21289a	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	master	basic-flow	t	t
c471afc3-1714-4397-a420-e97aa377a572	Authentication Options	Authentication options.	master	basic-flow	f	t
92de6ba5-d3ff-4d10-89cb-c178b84236e1	Account verification options	Method with which to verity the existing account	CC	basic-flow	f	t
1aa88ddb-2e10-4dad-9e7b-fe91f346d737	Authentication Options	Authentication options.	CC	basic-flow	f	t
86f11be9-8679-4bcf-82d1-eb9c021311b0	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	CC	basic-flow	f	t
9207b014-944a-486a-8a0d-b3ccc4de4404	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	CC	basic-flow	f	t
90aa0e87-cb07-4f94-b227-7dd00d1648e0	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	CC	basic-flow	f	t
f3c144f6-5a85-428f-ab82-daa91e159da8	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	CC	basic-flow	f	t
b2150b2f-5af0-4fcd-84b3-7c376f29db75	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	CC	basic-flow	f	t
1650b4a9-4056-4d05-b99b-564491ae6107	User creation or linking	Flow for the existing/non-existing user alternatives	CC	basic-flow	f	t
a72dfa99-efb7-466a-81a7-f27e0b4df010	Verify Existing Account by Re-authentication	Reauthentication of existing account	CC	basic-flow	f	t
6e85640d-e6c3-4b48-a8b9-12528e369bbd	browser	browser based authentication	CC	basic-flow	t	t
8a3d4c9a-f3c6-49c1-a932-625a993fa21e	clients	Base authentication for clients	CC	client-flow	t	t
1fdd1aef-9038-4dc3-ac05-bb746a360392	direct grant	OpenID Connect Resource Owner Grant	CC	basic-flow	t	t
a03fdfa5-3a9e-463e-a442-eaa822da1ee5	docker auth	Used by Docker clients to authenticate against the IDP	CC	basic-flow	t	t
e6aec560-8814-4813-9c1b-5169e1142449	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	CC	basic-flow	t	t
e081681c-4169-4c3f-b05c-cf0d63b09e44	forms	Username, password, otp and other auth forms.	CC	basic-flow	f	t
85f8b6ca-5309-4187-bbf0-56dc4b19fbb8	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	CC	basic-flow	t	t
1f7c329f-80fa-47f9-bf22-b0fb3fd3333b	registration	registration flow	CC	basic-flow	t	t
1feec0fb-d71e-431d-b1ef-2f2d44aa32a2	registration form	registration form	CC	form-flow	f	t
d52d288b-a24c-426c-9f10-5046c43f4e7f	reset credentials	Reset credentials for a user if they forgot their password or something	CC	basic-flow	t	t
ea812e2e-420a-4535-9416-22efea6dc7fb	saml ecp	SAML ECP Profile Authentication Flow	CC	basic-flow	t	t
\.


--
-- TOC entry 4123 (class 0 OID 42687)
-- Dependencies: 214
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
3e966fe1-1409-4d83-a21c-1b9635283935	review profile config	master
6e77f69c-05fc-40fc-8fef-984168a93bfe	create unique user config	master
5672748a-00db-4aa0-8b2a-f8490c7c894c	create unique user config	CC
18125f15-9c23-4998-90bf-d27ecdcb9cd4	review profile config	CC
\.


--
-- TOC entry 4124 (class 0 OID 42690)
-- Dependencies: 215
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
3e966fe1-1409-4d83-a21c-1b9635283935	missing	update.profile.on.first.login
6e77f69c-05fc-40fc-8fef-984168a93bfe	false	require.password.update.after.registration
5672748a-00db-4aa0-8b2a-f8490c7c894c	false	require.password.update.after.registration
18125f15-9c23-4998-90bf-d27ecdcb9cd4	missing	update.profile.on.first.login
\.


--
-- TOC entry 4125 (class 0 OID 42695)
-- Dependencies: 216
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- TOC entry 4126 (class 0 OID 42700)
-- Dependencies: 217
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
afddb56d-0c09-4bb5-ba70-3d594f19d404	t	f	master-realm	0	f	\N	\N	t	\N	f	master	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
df754331-dc4c-4886-aa39-4a7ac747b383	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	master	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
8433c1fd-5ede-4535-a056-2e4b8c0a289a	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	master	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
b4c6f356-3437-48fd-9b9b-0d7a0465ae07	t	f	broker	0	f	\N	\N	t	\N	f	master	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
9b7ac9ff-5213-44a3-988c-a6f181f31507	t	f	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	master	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
2a6f9e64-2bdd-4928-a565-ebc71d92bb90	t	f	admin-cli	0	t	\N	\N	f	\N	f	master	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
f0f69f18-4c7f-4850-a6f3-8bc4b0189408	t	f	security-admin-console	0	t	\N	/admin/CC/console/	f	\N	f	CC	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
57d0ab0d-d25b-4b1d-91ee-1ed79754e651	t	f	realm-management	0	f	\N	\N	f	\N	f	CC	openid-connect	0	f	f	${client_realm-management}	t	client-secret	\N	\N	\N	t	f	f	f
56449e2a-41ae-45cd-9c21-464cbe5c43f1	t	f	CC-realm	0	f	\N	\N	t	\N	f	master	\N	0	f	f	CC Realm	f	client-secret	\N	\N	\N	t	f	f	f
006df867-19d0-4bbc-9de7-f01ca96aaf7a	t	f	account	0	t	\N	/realms/CC/account/	f	\N	f	CC	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
87ae7e2b-85a5-4f5c-a55b-4596d7dd3baa	t	f	account-console	0	t	\N	/realms/CC/account/	f	\N	f	CC	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	t	t	admin-cc	0	f	**********	\N	f	\N	f	CC	openid-connect	-1	f	f	\N	t	client-secret	\N	\N	\N	f	f	f	f
7c2584c8-c873-46c2-a06f-5d9fbea99100	t	f	admin-cli	0	t	\N	\N	f	\N	f	CC	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
dcfd7631-d53e-4bce-b337-40ec363a561e	t	f	broker	0	f	\N	\N	t	\N	f	CC	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
0ac48ba0-1e20-4236-8749-bed43d1a2737	t	t	login	0	t	\N	\N	f	\N	f	CC	openid-connect	-1	f	f	\N	f	client-secret	\N	\N	\N	t	f	t	f
\.


--
-- TOC entry 4127 (class 0 OID 42718)
-- Dependencies: 218
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_attributes (client_id, value, name) FROM stdin;
8433c1fd-5ede-4535-a056-2e4b8c0a289a	S256	pkce.code.challenge.method
9b7ac9ff-5213-44a3-988c-a6f181f31507	S256	pkce.code.challenge.method
87ae7e2b-85a5-4f5c-a55b-4596d7dd3baa	false	saml.assertion.signature
87ae7e2b-85a5-4f5c-a55b-4596d7dd3baa	false	id.token.as.detached.signature
87ae7e2b-85a5-4f5c-a55b-4596d7dd3baa	false	saml.multivalued.roles
87ae7e2b-85a5-4f5c-a55b-4596d7dd3baa	false	saml.force.post.binding
87ae7e2b-85a5-4f5c-a55b-4596d7dd3baa	false	saml.encrypt
87ae7e2b-85a5-4f5c-a55b-4596d7dd3baa	false	oauth2.device.authorization.grant.enabled
87ae7e2b-85a5-4f5c-a55b-4596d7dd3baa	false	saml.server.signature
87ae7e2b-85a5-4f5c-a55b-4596d7dd3baa	false	backchannel.logout.revoke.offline.tokens
87ae7e2b-85a5-4f5c-a55b-4596d7dd3baa	false	saml.server.signature.keyinfo.ext
87ae7e2b-85a5-4f5c-a55b-4596d7dd3baa	true	use.refresh.tokens
87ae7e2b-85a5-4f5c-a55b-4596d7dd3baa	false	exclude.session.state.from.auth.response
87ae7e2b-85a5-4f5c-a55b-4596d7dd3baa	false	oidc.ciba.grant.enabled
87ae7e2b-85a5-4f5c-a55b-4596d7dd3baa	false	saml.artifact.binding
87ae7e2b-85a5-4f5c-a55b-4596d7dd3baa	false	backchannel.logout.session.required
87ae7e2b-85a5-4f5c-a55b-4596d7dd3baa	false	client_credentials.use_refresh_token
87ae7e2b-85a5-4f5c-a55b-4596d7dd3baa	false	saml_force_name_id_format
87ae7e2b-85a5-4f5c-a55b-4596d7dd3baa	false	saml.client.signature
87ae7e2b-85a5-4f5c-a55b-4596d7dd3baa	false	tls.client.certificate.bound.access.tokens
87ae7e2b-85a5-4f5c-a55b-4596d7dd3baa	false	saml.authnstatement
87ae7e2b-85a5-4f5c-a55b-4596d7dd3baa	false	display.on.consent.screen
87ae7e2b-85a5-4f5c-a55b-4596d7dd3baa	S256	pkce.code.challenge.method
87ae7e2b-85a5-4f5c-a55b-4596d7dd3baa	false	saml.onetimeuse.condition
99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	false	saml.assertion.signature
99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	false	id.token.as.detached.signature
99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	false	saml.multivalued.roles
99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	false	saml.force.post.binding
99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	false	saml.encrypt
99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	false	oauth2.device.authorization.grant.enabled
99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	false	backchannel.logout.revoke.offline.tokens
99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	false	saml.server.signature
99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	false	saml.server.signature.keyinfo.ext
99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	true	use.refresh.tokens
99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	false	exclude.session.state.from.auth.response
99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	false	oidc.ciba.grant.enabled
99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	false	saml.artifact.binding
99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	true	backchannel.logout.session.required
99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	false	client_credentials.use_refresh_token
99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	false	saml_force_name_id_format
99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	false	saml.client.signature
99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	false	tls.client.certificate.bound.access.tokens
99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	false	saml.authnstatement
99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	false	display.on.consent.screen
99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	false	saml.onetimeuse.condition
0ac48ba0-1e20-4236-8749-bed43d1a2737	false	saml.assertion.signature
0ac48ba0-1e20-4236-8749-bed43d1a2737	false	id.token.as.detached.signature
0ac48ba0-1e20-4236-8749-bed43d1a2737	false	saml.multivalued.roles
0ac48ba0-1e20-4236-8749-bed43d1a2737	false	saml.force.post.binding
0ac48ba0-1e20-4236-8749-bed43d1a2737	false	saml.encrypt
0ac48ba0-1e20-4236-8749-bed43d1a2737	false	oauth2.device.authorization.grant.enabled
0ac48ba0-1e20-4236-8749-bed43d1a2737	false	backchannel.logout.revoke.offline.tokens
0ac48ba0-1e20-4236-8749-bed43d1a2737	false	saml.server.signature
0ac48ba0-1e20-4236-8749-bed43d1a2737	false	saml.server.signature.keyinfo.ext
0ac48ba0-1e20-4236-8749-bed43d1a2737	true	use.refresh.tokens
0ac48ba0-1e20-4236-8749-bed43d1a2737	false	exclude.session.state.from.auth.response
0ac48ba0-1e20-4236-8749-bed43d1a2737	false	oidc.ciba.grant.enabled
0ac48ba0-1e20-4236-8749-bed43d1a2737	false	saml.artifact.binding
0ac48ba0-1e20-4236-8749-bed43d1a2737	true	backchannel.logout.session.required
0ac48ba0-1e20-4236-8749-bed43d1a2737	false	client_credentials.use_refresh_token
0ac48ba0-1e20-4236-8749-bed43d1a2737	false	saml_force_name_id_format
0ac48ba0-1e20-4236-8749-bed43d1a2737	false	saml.client.signature
0ac48ba0-1e20-4236-8749-bed43d1a2737	false	tls.client.certificate.bound.access.tokens
0ac48ba0-1e20-4236-8749-bed43d1a2737	false	saml.authnstatement
0ac48ba0-1e20-4236-8749-bed43d1a2737	false	display.on.consent.screen
0ac48ba0-1e20-4236-8749-bed43d1a2737	false	saml.onetimeuse.condition
f0f69f18-4c7f-4850-a6f3-8bc4b0189408	S256	pkce.code.challenge.method
\.


--
-- TOC entry 4128 (class 0 OID 42723)
-- Dependencies: 219
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- TOC entry 4129 (class 0 OID 42726)
-- Dependencies: 220
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- TOC entry 4130 (class 0 OID 42729)
-- Dependencies: 221
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- TOC entry 4131 (class 0 OID 42732)
-- Dependencies: 222
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
4af24db3-e37c-4cd7-b7b6-6ebd90e552fe	offline_access	master	OpenID Connect built-in scope: offline_access	openid-connect
1fbbf0e1-c81a-4757-90d1-a8b65a6eac26	role_list	master	SAML role list	saml
dc6899d1-5be4-40c7-8664-7baf2178f8be	profile	master	OpenID Connect built-in scope: profile	openid-connect
20831ba4-8f6e-41c9-8f1e-e625242a8e0c	email	master	OpenID Connect built-in scope: email	openid-connect
73953e93-d388-40b3-85cc-d2ebc1f6fbb0	address	master	OpenID Connect built-in scope: address	openid-connect
d7691612-6a6a-4ddd-a188-ddbfadfb8a9c	phone	master	OpenID Connect built-in scope: phone	openid-connect
33e00a2e-fadf-4389-a762-0118a9c1badb	roles	master	OpenID Connect scope for add user roles to the access token	openid-connect
309eaf84-3a62-41cd-82b6-65ca26f3a731	web-origins	master	OpenID Connect scope for add allowed web origins to the access token	openid-connect
9d2741a0-6c1f-41fd-b8ef-76e99a594225	microprofile-jwt	master	Microprofile - JWT built-in scope	openid-connect
72d38159-ce38-477d-b26a-695d1be288d8	phone	CC	OpenID Connect built-in scope: phone	openid-connect
c15c5363-490a-48d2-9edf-b12d8669b7cf	offline_access	CC	OpenID Connect built-in scope: offline_access	openid-connect
4cf73263-9888-43d5-af5b-fc70ea4b99be	address	CC	OpenID Connect built-in scope: address	openid-connect
13ac6628-4572-4335-a50c-2761c21c3cc0	profile	CC	OpenID Connect built-in scope: profile	openid-connect
0fb0feeb-c8d3-4a65-889d-fd69ce493eab	email	CC	OpenID Connect built-in scope: email	openid-connect
323bbbd8-2c6c-4080-a351-7f4cf8fd42b2	web-origins	CC	OpenID Connect scope for add allowed web origins to the access token	openid-connect
fc4ba834-d258-4deb-9b04-5dac5518559a	role_list	CC	SAML role list	saml
bcca4bf3-80df-4c1c-9394-36b7263928b8	microprofile-jwt	CC	Microprofile - JWT built-in scope	openid-connect
708c7fd8-1731-4cf9-8ea2-5b3bb57d65d6	roles	CC	OpenID Connect scope for add user roles to the access token	openid-connect
\.


--
-- TOC entry 4132 (class 0 OID 42737)
-- Dependencies: 223
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
4af24db3-e37c-4cd7-b7b6-6ebd90e552fe	true	display.on.consent.screen
4af24db3-e37c-4cd7-b7b6-6ebd90e552fe	${offlineAccessScopeConsentText}	consent.screen.text
1fbbf0e1-c81a-4757-90d1-a8b65a6eac26	true	display.on.consent.screen
1fbbf0e1-c81a-4757-90d1-a8b65a6eac26	${samlRoleListScopeConsentText}	consent.screen.text
dc6899d1-5be4-40c7-8664-7baf2178f8be	true	display.on.consent.screen
dc6899d1-5be4-40c7-8664-7baf2178f8be	${profileScopeConsentText}	consent.screen.text
dc6899d1-5be4-40c7-8664-7baf2178f8be	true	include.in.token.scope
20831ba4-8f6e-41c9-8f1e-e625242a8e0c	true	display.on.consent.screen
20831ba4-8f6e-41c9-8f1e-e625242a8e0c	${emailScopeConsentText}	consent.screen.text
20831ba4-8f6e-41c9-8f1e-e625242a8e0c	true	include.in.token.scope
73953e93-d388-40b3-85cc-d2ebc1f6fbb0	true	display.on.consent.screen
73953e93-d388-40b3-85cc-d2ebc1f6fbb0	${addressScopeConsentText}	consent.screen.text
73953e93-d388-40b3-85cc-d2ebc1f6fbb0	true	include.in.token.scope
d7691612-6a6a-4ddd-a188-ddbfadfb8a9c	true	display.on.consent.screen
d7691612-6a6a-4ddd-a188-ddbfadfb8a9c	${phoneScopeConsentText}	consent.screen.text
d7691612-6a6a-4ddd-a188-ddbfadfb8a9c	true	include.in.token.scope
33e00a2e-fadf-4389-a762-0118a9c1badb	true	display.on.consent.screen
33e00a2e-fadf-4389-a762-0118a9c1badb	${rolesScopeConsentText}	consent.screen.text
33e00a2e-fadf-4389-a762-0118a9c1badb	false	include.in.token.scope
309eaf84-3a62-41cd-82b6-65ca26f3a731	false	display.on.consent.screen
309eaf84-3a62-41cd-82b6-65ca26f3a731		consent.screen.text
309eaf84-3a62-41cd-82b6-65ca26f3a731	false	include.in.token.scope
9d2741a0-6c1f-41fd-b8ef-76e99a594225	false	display.on.consent.screen
9d2741a0-6c1f-41fd-b8ef-76e99a594225	true	include.in.token.scope
72d38159-ce38-477d-b26a-695d1be288d8	true	include.in.token.scope
72d38159-ce38-477d-b26a-695d1be288d8	true	display.on.consent.screen
72d38159-ce38-477d-b26a-695d1be288d8	${phoneScopeConsentText}	consent.screen.text
c15c5363-490a-48d2-9edf-b12d8669b7cf	${offlineAccessScopeConsentText}	consent.screen.text
c15c5363-490a-48d2-9edf-b12d8669b7cf	true	display.on.consent.screen
4cf73263-9888-43d5-af5b-fc70ea4b99be	true	include.in.token.scope
4cf73263-9888-43d5-af5b-fc70ea4b99be	true	display.on.consent.screen
4cf73263-9888-43d5-af5b-fc70ea4b99be	${addressScopeConsentText}	consent.screen.text
13ac6628-4572-4335-a50c-2761c21c3cc0	true	include.in.token.scope
13ac6628-4572-4335-a50c-2761c21c3cc0	true	display.on.consent.screen
13ac6628-4572-4335-a50c-2761c21c3cc0	${profileScopeConsentText}	consent.screen.text
0fb0feeb-c8d3-4a65-889d-fd69ce493eab	true	include.in.token.scope
0fb0feeb-c8d3-4a65-889d-fd69ce493eab	true	display.on.consent.screen
0fb0feeb-c8d3-4a65-889d-fd69ce493eab	${emailScopeConsentText}	consent.screen.text
323bbbd8-2c6c-4080-a351-7f4cf8fd42b2	false	include.in.token.scope
323bbbd8-2c6c-4080-a351-7f4cf8fd42b2	false	display.on.consent.screen
323bbbd8-2c6c-4080-a351-7f4cf8fd42b2		consent.screen.text
fc4ba834-d258-4deb-9b04-5dac5518559a	${samlRoleListScopeConsentText}	consent.screen.text
fc4ba834-d258-4deb-9b04-5dac5518559a	true	display.on.consent.screen
bcca4bf3-80df-4c1c-9394-36b7263928b8	true	include.in.token.scope
bcca4bf3-80df-4c1c-9394-36b7263928b8	false	display.on.consent.screen
708c7fd8-1731-4cf9-8ea2-5b3bb57d65d6	false	include.in.token.scope
708c7fd8-1731-4cf9-8ea2-5b3bb57d65d6	true	display.on.consent.screen
708c7fd8-1731-4cf9-8ea2-5b3bb57d65d6	${rolesScopeConsentText}	consent.screen.text
\.


--
-- TOC entry 4133 (class 0 OID 42742)
-- Dependencies: 224
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
df754331-dc4c-4886-aa39-4a7ac747b383	dc6899d1-5be4-40c7-8664-7baf2178f8be	t
df754331-dc4c-4886-aa39-4a7ac747b383	309eaf84-3a62-41cd-82b6-65ca26f3a731	t
df754331-dc4c-4886-aa39-4a7ac747b383	20831ba4-8f6e-41c9-8f1e-e625242a8e0c	t
df754331-dc4c-4886-aa39-4a7ac747b383	33e00a2e-fadf-4389-a762-0118a9c1badb	t
df754331-dc4c-4886-aa39-4a7ac747b383	9d2741a0-6c1f-41fd-b8ef-76e99a594225	f
df754331-dc4c-4886-aa39-4a7ac747b383	4af24db3-e37c-4cd7-b7b6-6ebd90e552fe	f
df754331-dc4c-4886-aa39-4a7ac747b383	73953e93-d388-40b3-85cc-d2ebc1f6fbb0	f
df754331-dc4c-4886-aa39-4a7ac747b383	d7691612-6a6a-4ddd-a188-ddbfadfb8a9c	f
8433c1fd-5ede-4535-a056-2e4b8c0a289a	dc6899d1-5be4-40c7-8664-7baf2178f8be	t
8433c1fd-5ede-4535-a056-2e4b8c0a289a	309eaf84-3a62-41cd-82b6-65ca26f3a731	t
8433c1fd-5ede-4535-a056-2e4b8c0a289a	20831ba4-8f6e-41c9-8f1e-e625242a8e0c	t
8433c1fd-5ede-4535-a056-2e4b8c0a289a	33e00a2e-fadf-4389-a762-0118a9c1badb	t
8433c1fd-5ede-4535-a056-2e4b8c0a289a	9d2741a0-6c1f-41fd-b8ef-76e99a594225	f
8433c1fd-5ede-4535-a056-2e4b8c0a289a	4af24db3-e37c-4cd7-b7b6-6ebd90e552fe	f
8433c1fd-5ede-4535-a056-2e4b8c0a289a	73953e93-d388-40b3-85cc-d2ebc1f6fbb0	f
8433c1fd-5ede-4535-a056-2e4b8c0a289a	d7691612-6a6a-4ddd-a188-ddbfadfb8a9c	f
2a6f9e64-2bdd-4928-a565-ebc71d92bb90	dc6899d1-5be4-40c7-8664-7baf2178f8be	t
2a6f9e64-2bdd-4928-a565-ebc71d92bb90	309eaf84-3a62-41cd-82b6-65ca26f3a731	t
2a6f9e64-2bdd-4928-a565-ebc71d92bb90	20831ba4-8f6e-41c9-8f1e-e625242a8e0c	t
2a6f9e64-2bdd-4928-a565-ebc71d92bb90	33e00a2e-fadf-4389-a762-0118a9c1badb	t
2a6f9e64-2bdd-4928-a565-ebc71d92bb90	9d2741a0-6c1f-41fd-b8ef-76e99a594225	f
2a6f9e64-2bdd-4928-a565-ebc71d92bb90	4af24db3-e37c-4cd7-b7b6-6ebd90e552fe	f
2a6f9e64-2bdd-4928-a565-ebc71d92bb90	73953e93-d388-40b3-85cc-d2ebc1f6fbb0	f
2a6f9e64-2bdd-4928-a565-ebc71d92bb90	d7691612-6a6a-4ddd-a188-ddbfadfb8a9c	f
b4c6f356-3437-48fd-9b9b-0d7a0465ae07	dc6899d1-5be4-40c7-8664-7baf2178f8be	t
b4c6f356-3437-48fd-9b9b-0d7a0465ae07	309eaf84-3a62-41cd-82b6-65ca26f3a731	t
b4c6f356-3437-48fd-9b9b-0d7a0465ae07	20831ba4-8f6e-41c9-8f1e-e625242a8e0c	t
b4c6f356-3437-48fd-9b9b-0d7a0465ae07	33e00a2e-fadf-4389-a762-0118a9c1badb	t
b4c6f356-3437-48fd-9b9b-0d7a0465ae07	9d2741a0-6c1f-41fd-b8ef-76e99a594225	f
b4c6f356-3437-48fd-9b9b-0d7a0465ae07	4af24db3-e37c-4cd7-b7b6-6ebd90e552fe	f
b4c6f356-3437-48fd-9b9b-0d7a0465ae07	73953e93-d388-40b3-85cc-d2ebc1f6fbb0	f
b4c6f356-3437-48fd-9b9b-0d7a0465ae07	d7691612-6a6a-4ddd-a188-ddbfadfb8a9c	f
afddb56d-0c09-4bb5-ba70-3d594f19d404	dc6899d1-5be4-40c7-8664-7baf2178f8be	t
afddb56d-0c09-4bb5-ba70-3d594f19d404	309eaf84-3a62-41cd-82b6-65ca26f3a731	t
afddb56d-0c09-4bb5-ba70-3d594f19d404	20831ba4-8f6e-41c9-8f1e-e625242a8e0c	t
afddb56d-0c09-4bb5-ba70-3d594f19d404	33e00a2e-fadf-4389-a762-0118a9c1badb	t
afddb56d-0c09-4bb5-ba70-3d594f19d404	9d2741a0-6c1f-41fd-b8ef-76e99a594225	f
afddb56d-0c09-4bb5-ba70-3d594f19d404	4af24db3-e37c-4cd7-b7b6-6ebd90e552fe	f
afddb56d-0c09-4bb5-ba70-3d594f19d404	73953e93-d388-40b3-85cc-d2ebc1f6fbb0	f
afddb56d-0c09-4bb5-ba70-3d594f19d404	d7691612-6a6a-4ddd-a188-ddbfadfb8a9c	f
9b7ac9ff-5213-44a3-988c-a6f181f31507	dc6899d1-5be4-40c7-8664-7baf2178f8be	t
9b7ac9ff-5213-44a3-988c-a6f181f31507	309eaf84-3a62-41cd-82b6-65ca26f3a731	t
9b7ac9ff-5213-44a3-988c-a6f181f31507	20831ba4-8f6e-41c9-8f1e-e625242a8e0c	t
9b7ac9ff-5213-44a3-988c-a6f181f31507	33e00a2e-fadf-4389-a762-0118a9c1badb	t
9b7ac9ff-5213-44a3-988c-a6f181f31507	9d2741a0-6c1f-41fd-b8ef-76e99a594225	f
9b7ac9ff-5213-44a3-988c-a6f181f31507	4af24db3-e37c-4cd7-b7b6-6ebd90e552fe	f
9b7ac9ff-5213-44a3-988c-a6f181f31507	73953e93-d388-40b3-85cc-d2ebc1f6fbb0	f
9b7ac9ff-5213-44a3-988c-a6f181f31507	d7691612-6a6a-4ddd-a188-ddbfadfb8a9c	f
006df867-19d0-4bbc-9de7-f01ca96aaf7a	323bbbd8-2c6c-4080-a351-7f4cf8fd42b2	t
006df867-19d0-4bbc-9de7-f01ca96aaf7a	13ac6628-4572-4335-a50c-2761c21c3cc0	t
006df867-19d0-4bbc-9de7-f01ca96aaf7a	708c7fd8-1731-4cf9-8ea2-5b3bb57d65d6	t
006df867-19d0-4bbc-9de7-f01ca96aaf7a	0fb0feeb-c8d3-4a65-889d-fd69ce493eab	t
006df867-19d0-4bbc-9de7-f01ca96aaf7a	4cf73263-9888-43d5-af5b-fc70ea4b99be	f
006df867-19d0-4bbc-9de7-f01ca96aaf7a	72d38159-ce38-477d-b26a-695d1be288d8	f
006df867-19d0-4bbc-9de7-f01ca96aaf7a	c15c5363-490a-48d2-9edf-b12d8669b7cf	f
006df867-19d0-4bbc-9de7-f01ca96aaf7a	bcca4bf3-80df-4c1c-9394-36b7263928b8	f
87ae7e2b-85a5-4f5c-a55b-4596d7dd3baa	323bbbd8-2c6c-4080-a351-7f4cf8fd42b2	t
87ae7e2b-85a5-4f5c-a55b-4596d7dd3baa	13ac6628-4572-4335-a50c-2761c21c3cc0	t
87ae7e2b-85a5-4f5c-a55b-4596d7dd3baa	708c7fd8-1731-4cf9-8ea2-5b3bb57d65d6	t
87ae7e2b-85a5-4f5c-a55b-4596d7dd3baa	0fb0feeb-c8d3-4a65-889d-fd69ce493eab	t
87ae7e2b-85a5-4f5c-a55b-4596d7dd3baa	4cf73263-9888-43d5-af5b-fc70ea4b99be	f
87ae7e2b-85a5-4f5c-a55b-4596d7dd3baa	72d38159-ce38-477d-b26a-695d1be288d8	f
87ae7e2b-85a5-4f5c-a55b-4596d7dd3baa	c15c5363-490a-48d2-9edf-b12d8669b7cf	f
87ae7e2b-85a5-4f5c-a55b-4596d7dd3baa	bcca4bf3-80df-4c1c-9394-36b7263928b8	f
99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	323bbbd8-2c6c-4080-a351-7f4cf8fd42b2	t
99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	13ac6628-4572-4335-a50c-2761c21c3cc0	t
99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	708c7fd8-1731-4cf9-8ea2-5b3bb57d65d6	t
99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	0fb0feeb-c8d3-4a65-889d-fd69ce493eab	t
99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	4cf73263-9888-43d5-af5b-fc70ea4b99be	f
99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	72d38159-ce38-477d-b26a-695d1be288d8	f
99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	c15c5363-490a-48d2-9edf-b12d8669b7cf	f
99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	bcca4bf3-80df-4c1c-9394-36b7263928b8	f
7c2584c8-c873-46c2-a06f-5d9fbea99100	323bbbd8-2c6c-4080-a351-7f4cf8fd42b2	t
7c2584c8-c873-46c2-a06f-5d9fbea99100	13ac6628-4572-4335-a50c-2761c21c3cc0	t
7c2584c8-c873-46c2-a06f-5d9fbea99100	708c7fd8-1731-4cf9-8ea2-5b3bb57d65d6	t
7c2584c8-c873-46c2-a06f-5d9fbea99100	0fb0feeb-c8d3-4a65-889d-fd69ce493eab	t
7c2584c8-c873-46c2-a06f-5d9fbea99100	4cf73263-9888-43d5-af5b-fc70ea4b99be	f
7c2584c8-c873-46c2-a06f-5d9fbea99100	72d38159-ce38-477d-b26a-695d1be288d8	f
7c2584c8-c873-46c2-a06f-5d9fbea99100	c15c5363-490a-48d2-9edf-b12d8669b7cf	f
7c2584c8-c873-46c2-a06f-5d9fbea99100	bcca4bf3-80df-4c1c-9394-36b7263928b8	f
dcfd7631-d53e-4bce-b337-40ec363a561e	323bbbd8-2c6c-4080-a351-7f4cf8fd42b2	t
dcfd7631-d53e-4bce-b337-40ec363a561e	13ac6628-4572-4335-a50c-2761c21c3cc0	t
dcfd7631-d53e-4bce-b337-40ec363a561e	708c7fd8-1731-4cf9-8ea2-5b3bb57d65d6	t
dcfd7631-d53e-4bce-b337-40ec363a561e	0fb0feeb-c8d3-4a65-889d-fd69ce493eab	t
dcfd7631-d53e-4bce-b337-40ec363a561e	4cf73263-9888-43d5-af5b-fc70ea4b99be	f
dcfd7631-d53e-4bce-b337-40ec363a561e	72d38159-ce38-477d-b26a-695d1be288d8	f
dcfd7631-d53e-4bce-b337-40ec363a561e	c15c5363-490a-48d2-9edf-b12d8669b7cf	f
dcfd7631-d53e-4bce-b337-40ec363a561e	bcca4bf3-80df-4c1c-9394-36b7263928b8	f
0ac48ba0-1e20-4236-8749-bed43d1a2737	323bbbd8-2c6c-4080-a351-7f4cf8fd42b2	t
0ac48ba0-1e20-4236-8749-bed43d1a2737	13ac6628-4572-4335-a50c-2761c21c3cc0	t
0ac48ba0-1e20-4236-8749-bed43d1a2737	708c7fd8-1731-4cf9-8ea2-5b3bb57d65d6	t
0ac48ba0-1e20-4236-8749-bed43d1a2737	0fb0feeb-c8d3-4a65-889d-fd69ce493eab	t
0ac48ba0-1e20-4236-8749-bed43d1a2737	4cf73263-9888-43d5-af5b-fc70ea4b99be	f
0ac48ba0-1e20-4236-8749-bed43d1a2737	72d38159-ce38-477d-b26a-695d1be288d8	f
0ac48ba0-1e20-4236-8749-bed43d1a2737	c15c5363-490a-48d2-9edf-b12d8669b7cf	f
0ac48ba0-1e20-4236-8749-bed43d1a2737	bcca4bf3-80df-4c1c-9394-36b7263928b8	f
57d0ab0d-d25b-4b1d-91ee-1ed79754e651	323bbbd8-2c6c-4080-a351-7f4cf8fd42b2	t
57d0ab0d-d25b-4b1d-91ee-1ed79754e651	13ac6628-4572-4335-a50c-2761c21c3cc0	t
57d0ab0d-d25b-4b1d-91ee-1ed79754e651	708c7fd8-1731-4cf9-8ea2-5b3bb57d65d6	t
57d0ab0d-d25b-4b1d-91ee-1ed79754e651	0fb0feeb-c8d3-4a65-889d-fd69ce493eab	t
57d0ab0d-d25b-4b1d-91ee-1ed79754e651	4cf73263-9888-43d5-af5b-fc70ea4b99be	f
57d0ab0d-d25b-4b1d-91ee-1ed79754e651	72d38159-ce38-477d-b26a-695d1be288d8	f
57d0ab0d-d25b-4b1d-91ee-1ed79754e651	c15c5363-490a-48d2-9edf-b12d8669b7cf	f
57d0ab0d-d25b-4b1d-91ee-1ed79754e651	bcca4bf3-80df-4c1c-9394-36b7263928b8	f
f0f69f18-4c7f-4850-a6f3-8bc4b0189408	323bbbd8-2c6c-4080-a351-7f4cf8fd42b2	t
f0f69f18-4c7f-4850-a6f3-8bc4b0189408	13ac6628-4572-4335-a50c-2761c21c3cc0	t
f0f69f18-4c7f-4850-a6f3-8bc4b0189408	708c7fd8-1731-4cf9-8ea2-5b3bb57d65d6	t
f0f69f18-4c7f-4850-a6f3-8bc4b0189408	0fb0feeb-c8d3-4a65-889d-fd69ce493eab	t
f0f69f18-4c7f-4850-a6f3-8bc4b0189408	4cf73263-9888-43d5-af5b-fc70ea4b99be	f
f0f69f18-4c7f-4850-a6f3-8bc4b0189408	72d38159-ce38-477d-b26a-695d1be288d8	f
f0f69f18-4c7f-4850-a6f3-8bc4b0189408	c15c5363-490a-48d2-9edf-b12d8669b7cf	f
f0f69f18-4c7f-4850-a6f3-8bc4b0189408	bcca4bf3-80df-4c1c-9394-36b7263928b8	f
\.


--
-- TOC entry 4134 (class 0 OID 42748)
-- Dependencies: 225
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
4af24db3-e37c-4cd7-b7b6-6ebd90e552fe	802aa55a-b52a-435a-bff2-4a3401cff9bd
c15c5363-490a-48d2-9edf-b12d8669b7cf	008360b3-9666-404c-a2ad-788147654cac
\.


--
-- TOC entry 4135 (class 0 OID 42751)
-- Dependencies: 226
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- TOC entry 4136 (class 0 OID 42756)
-- Dependencies: 227
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- TOC entry 4137 (class 0 OID 42759)
-- Dependencies: 228
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- TOC entry 4138 (class 0 OID 42764)
-- Dependencies: 229
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- TOC entry 4139 (class 0 OID 42767)
-- Dependencies: 230
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- TOC entry 4140 (class 0 OID 42770)
-- Dependencies: 231
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- TOC entry 4141 (class 0 OID 42775)
-- Dependencies: 232
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
66cd8ff7-2bcd-4152-8cc5-e5efaaf19833	Trusted Hosts	master	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
4863dd4b-1d88-4734-9a84-5c72bce077fd	Consent Required	master	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
8944f0ff-8a59-4ca5-a935-8af8739e3adb	Full Scope Disabled	master	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
cff643ff-1cb1-48de-9ade-22ada83cce05	Max Clients Limit	master	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
4c93a558-b1a4-4288-9f6b-b27bc6887c70	Allowed Protocol Mapper Types	master	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
096cd444-2d1c-47dc-a0e3-ab30dd9628c3	Allowed Client Scopes	master	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
de850b88-4812-4c17-86a0-92d4aed74214	Allowed Protocol Mapper Types	master	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	authenticated
6f18a1b2-2b67-43fa-a364-892015be07a4	Allowed Client Scopes	master	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	authenticated
4c690546-7fae-44f8-adf2-3674db6f1c94	rsa-generated	master	rsa-generated	org.keycloak.keys.KeyProvider	master	\N
d0079104-6b5c-4b14-8ffe-a92077dd7176	hmac-generated	master	hmac-generated	org.keycloak.keys.KeyProvider	master	\N
cd1743fc-5668-438a-8ba2-8e70da633006	aes-generated	master	aes-generated	org.keycloak.keys.KeyProvider	master	\N
9c9a4167-3f00-4c0c-9685-4ff139ebfe72	Consent Required	CC	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	CC	anonymous
0fd2ae25-a3f2-4ce9-91bf-73a5a6e035b8	Full Scope Disabled	CC	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	CC	anonymous
8a8f46fd-61d7-4d30-830e-264c2fa4dd51	Allowed Client Scopes	CC	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	CC	anonymous
24ad13ce-359b-4b12-a2c5-0f3749f995e3	Max Clients Limit	CC	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	CC	anonymous
656c891e-5ccb-4353-bf9b-a00ee88056d0	Allowed Protocol Mapper Types	CC	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	CC	authenticated
27629b00-7708-44c4-a23b-87004e319759	Trusted Hosts	CC	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	CC	anonymous
e6cba7a8-9e08-48ff-b512-e55270fe383f	Allowed Protocol Mapper Types	CC	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	CC	anonymous
2d51c5b8-5627-4412-a8a0-75d1484deed2	Allowed Client Scopes	CC	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	CC	authenticated
afece65e-a27f-407a-bcf2-f9a81a5d963c	aes-generated	CC	aes-generated	org.keycloak.keys.KeyProvider	CC	\N
81097085-6d41-4f59-abf1-0d0f7c359645	rsa-generated	CC	rsa-generated	org.keycloak.keys.KeyProvider	CC	\N
d02da4f3-e1ae-4499-9fb7-3b87effdfc6d	hmac-generated	CC	hmac-generated	org.keycloak.keys.KeyProvider	CC	\N
\.


--
-- TOC entry 4142 (class 0 OID 42780)
-- Dependencies: 233
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
3948cd33-7587-4b79-875c-67ae051addad	de850b88-4812-4c17-86a0-92d4aed74214	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
83b004a6-6fb0-48be-9a9a-ff26a3502fe3	de850b88-4812-4c17-86a0-92d4aed74214	allowed-protocol-mapper-types	oidc-address-mapper
14c95a3c-f54b-404c-8fad-c1b8bf3e245c	de850b88-4812-4c17-86a0-92d4aed74214	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
74b97a78-831a-42e2-94a8-64ce11ea4e52	de850b88-4812-4c17-86a0-92d4aed74214	allowed-protocol-mapper-types	saml-role-list-mapper
1a618619-a18a-46c1-8a32-fa905f2c2d67	de850b88-4812-4c17-86a0-92d4aed74214	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
65e39509-0630-4f88-9c00-47036033170d	de850b88-4812-4c17-86a0-92d4aed74214	allowed-protocol-mapper-types	oidc-full-name-mapper
6bcaa7c4-daa2-4c2c-a174-c6fc3c312f94	de850b88-4812-4c17-86a0-92d4aed74214	allowed-protocol-mapper-types	saml-user-property-mapper
2a2e5026-032b-43d6-80f1-a6663a54c728	de850b88-4812-4c17-86a0-92d4aed74214	allowed-protocol-mapper-types	saml-user-attribute-mapper
4c22af9b-0912-4a75-94ea-4b379011b601	4c93a558-b1a4-4288-9f6b-b27bc6887c70	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
ac2fc09d-4d57-4d7d-895f-bdc88cf2e4bc	4c93a558-b1a4-4288-9f6b-b27bc6887c70	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
d36783af-e7cb-4daa-8917-159c5471b7b4	4c93a558-b1a4-4288-9f6b-b27bc6887c70	allowed-protocol-mapper-types	saml-user-attribute-mapper
c8f28b1f-1f8e-4658-ab31-7249467c6a8d	4c93a558-b1a4-4288-9f6b-b27bc6887c70	allowed-protocol-mapper-types	saml-user-property-mapper
e468e8fa-93dd-4f3d-9109-7a80c3d16b2c	4c93a558-b1a4-4288-9f6b-b27bc6887c70	allowed-protocol-mapper-types	oidc-full-name-mapper
3a000f1c-15f2-4a15-9e6b-54bac2b5e718	4c93a558-b1a4-4288-9f6b-b27bc6887c70	allowed-protocol-mapper-types	oidc-address-mapper
81b6b974-9fed-43f9-9481-2cb79e5fb562	4c93a558-b1a4-4288-9f6b-b27bc6887c70	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
1e8191e6-f5e7-4497-aea4-848a2029989a	4c93a558-b1a4-4288-9f6b-b27bc6887c70	allowed-protocol-mapper-types	saml-role-list-mapper
551f928e-9e10-4ce7-8a34-eacfe32aee54	cff643ff-1cb1-48de-9ade-22ada83cce05	max-clients	200
f6ac50ef-1b1a-4ad1-bf1c-60737907a8ee	6f18a1b2-2b67-43fa-a364-892015be07a4	allow-default-scopes	true
2ec462d8-8b4b-4668-8e49-114570879edc	66cd8ff7-2bcd-4152-8cc5-e5efaaf19833	client-uris-must-match	true
73fbf5f3-2424-4d45-8590-65b078e67772	66cd8ff7-2bcd-4152-8cc5-e5efaaf19833	host-sending-registration-request-must-match	true
289fae64-5034-47d7-bb69-fcf734bf73e0	096cd444-2d1c-47dc-a0e3-ab30dd9628c3	allow-default-scopes	true
5654bfaa-7948-4921-b159-a3bc571b253e	4c690546-7fae-44f8-adf2-3674db6f1c94	priority	100
e95568a4-39cb-4b1c-8ab4-12c31efa9dfa	4c690546-7fae-44f8-adf2-3674db6f1c94	certificate	MIICmzCCAYMCBgF8fiqb3zANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjExMDE0MDkzNjM0WhcNMzExMDE0MDkzODE0WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC3cI1MElFl/qcipEIPqxsIB8nKK88yIPesGoMIEX/ZYimrCz4WJfUvuA6G72uxC5ap0RvL5EBYIDblS3vrRr/rFi5BbLCUHhfnEaoslaNU6P5mgO8Uw6R3guAz4BBRxoTQBCDFa47pgprD1d2IYfzUSApcRbGgf4CYvfNpekHxsi6fpDVIZLNoYFIZVytegVwOdky5QzrYAPW8Mt6un8DN211vUybcMuVBqjVFyjc+pXCBDz7ns9S41MSRCqXOx57x53Jbi+Rgjf3CEdreHf37PFPBw2W9+lEz1iobd/BT1QlzsKccYNP9MqAbuDRn2C9Ha/vZFiQmhZ4EbAMqVJ9pAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAEvG+EJZH2AD3R41zyouXOZq+vQMM9W4h0XSsjinrT4UR6OmmW0+F2xCjellZIdbaSr/iUJUtepoxLCevygmIgpowUB06vJyC+VZ3xUqEpuPf02SfWVvSaGWB7lc12AIwUKyn7NWD6K8D9gmHgCpH8PeXxkFzGSLtZiylb+byjssFPYVXPHk8GzTo6HPaz9aTPzBmCEW2kzH9lgdBG3GoekqgK5BWx8zIYDiWmcSbPLw7JlWWa8wexpXz0e3Lw8NY6GjigKEA5OCSoWH5MFIi3Y2L4sef0z9QDr6MlkWwYtlV1FfPd+ZnhsSL2o2Ii5sqYPmWDJ58ISd8ffx9C5xbk0=
d64df47b-1170-4cbb-897f-04882d471a4d	4c690546-7fae-44f8-adf2-3674db6f1c94	privateKey	MIIEowIBAAKCAQEAt3CNTBJRZf6nIqRCD6sbCAfJyivPMiD3rBqDCBF/2WIpqws+FiX1L7gOhu9rsQuWqdEby+RAWCA25Ut760a/6xYuQWywlB4X5xGqLJWjVOj+ZoDvFMOkd4LgM+AQUcaE0AQgxWuO6YKaw9XdiGH81EgKXEWxoH+AmL3zaXpB8bIun6Q1SGSzaGBSGVcrXoFcDnZMuUM62AD1vDLerp/Azdtdb1Mm3DLlQao1Rco3PqVwgQ8+57PUuNTEkQqlzsee8edyW4vkYI39whHa3h39+zxTwcNlvfpRM9YqG3fwU9UJc7CnHGDT/TKgG7g0Z9gvR2v72RYkJoWeBGwDKlSfaQIDAQABAoIBAEce0xl4TKjPt3sd1iL/Aub1Jg5FN/rGf1/xk3XQWxIsFd2j6TlrFAmhQbidINKunIZQdYdygmPocYAq6OuKLaR2oA5rlnaGyFulJKZOidnEz8VsHcWeKKjRTB2wtIMQBbQktZP1JJ5yLZDZ3R8gZobjO2kU+E4ywOf3VWVCqkiLVXp/eo9F22j7MXqdmwwQntXDLFejbE8kzb/rvzemHVk5gQug1slqaLF1Mj5386GHAU/aJBTolSKK5+WxTXqGJahCY+4vn0labEEBrrf9k2dRxxiZ8ZS9pilCA8li3grs3ewe2+oI1+3zabHjsZ79VceiO3ZhK8sk/EhAKr1tyJECgYEA49+FnnkhS5LeBobgcxmVOJL86g/0Rr9mj8JCVwc2YEk18FmPW8kLOqaN4b1JBGIa/zZz/ZozYsnrFFZUcDGNcMtJbEp66jG0OsZMJeWhuxPIzQSJ6LYuAZEIc9IpTXAt0GT06+o0j22xxM7uk5N5Wa0zzjx5iPj7l9Hp/FRMb90CgYEAzhT+P0oD1Z/xeurSd7sjQsgyTdPrLft5g5mgQna5nZ7iKBGa3R3sX3oI9Gq7B3aAzV6uhPy7g+0eelTLWwE/S/BkaXZllXOjAc7T3YQ0c55dOc0klzV8llWYg8PyFNoDHrszyV9xbykTYicu4312ZHf5TE39InbO2n0j55EaOv0CgYAn/hzHWV78koQhBR7zVHQZ/8Ifmjk3CXSImoFmIL/sWiz7R9yfMUOlQYH5Mm1UNZujWv00bxHBrspxQU2Ee03lk+gI93FnFN4ayp6msAyYdrpxMPC7RO4CHGAtY58YFi4UOwO5O9uJqKjgb6jzgZh0oq9K7NYvsfMGDDNSs8DOiQKBgQCrXqW2N3RM1r5WOqNeUU4XIKdENO+iwzXfC4dK/bOIsTDbpRgku9dt5etAZOi2YgLlxNBXYlsEb9AiZhTczoK2QWcelAgRaaGpxTZFRMThSFW51S+SVjYORYuYNv89+7UQfxenYyjPCVdHDdJd9lzXWzUCEPBpEmcdJWcQD4fCeQKBgCYZjlFGrmdC6x2TMT+kWqg0ZKnsYseAle0YnVU5WLoTmjabMNV74LQAoGFcdpAYV/cWzM+0/+Be5VmW+k8onaNLHhuUdM3mpqMydLW2/ip1L/9e5zk8GDM0ZD/MfSncilu1PYTQdz4dk7Xai+1+vj2dUKctHfl2IkylMEhHzi64
3aa647f0-3c68-4c00-9c35-9ef9010a5a29	cd1743fc-5668-438a-8ba2-8e70da633006	priority	100
1687197b-7386-4089-a9d8-80469bcbb9d3	cd1743fc-5668-438a-8ba2-8e70da633006	secret	B5ZigG7ozw3Ys1CUIfcUHg
ba543763-44fb-46ff-8a33-efc369cd3ce3	cd1743fc-5668-438a-8ba2-8e70da633006	kid	c97bbd1f-5ca7-452c-bae0-5a2c7ef30cc7
e1338d1a-4836-42aa-9fd4-a7490ab00505	d0079104-6b5c-4b14-8ffe-a92077dd7176	priority	100
8324c89f-9448-4bf7-9228-8b205512682a	d0079104-6b5c-4b14-8ffe-a92077dd7176	secret	Mgv4xiEdUyBUy_QrGNnHGTtVcG44TiPokrEhdMy87sLGKx0Nl7HVY90dX4t-H8u5UEcG5jUCJomy4Wzzpay6SQ
ce012aea-f0dc-4065-b9a2-8665977097a3	d0079104-6b5c-4b14-8ffe-a92077dd7176	algorithm	HS256
2da80a5e-1d61-4894-87ec-ddc54bea315d	d0079104-6b5c-4b14-8ffe-a92077dd7176	kid	358d6e00-319c-492a-ad7a-5d3122446c4b
28b471ca-a012-4fa5-a523-fe4a2ffa3372	8a8f46fd-61d7-4d30-830e-264c2fa4dd51	allow-default-scopes	true
0f5320f1-c3bb-4b62-905c-990ad4bae82c	afece65e-a27f-407a-bcf2-f9a81a5d963c	secret	rZjOXG6c8ft00QibYmaONA
13a552cc-759c-4216-a4a8-a6839ff9d90c	afece65e-a27f-407a-bcf2-f9a81a5d963c	kid	b86e965d-e804-42f1-9e54-bc95caa6fae8
0102c9d5-1606-4c41-965d-8004ee3997a9	afece65e-a27f-407a-bcf2-f9a81a5d963c	priority	100
cdd1ce22-21cc-48fd-8572-3dcd7705ede5	24ad13ce-359b-4b12-a2c5-0f3749f995e3	max-clients	200
2915e8b5-97c4-4f6a-b03f-d65eff7192d8	81097085-6d41-4f59-abf1-0d0f7c359645	priority	100
e7e10d70-968e-45e0-b381-f3f3fb6e251f	81097085-6d41-4f59-abf1-0d0f7c359645	certificate	MIICkzCCAXsCBgF/jcW70zANBgkqhkiG9w0BAQsFADANMQswCQYDVQQDDAJDQzAeFw0yMjAzMTUxMzI4NDBaFw0zMjAzMTUxMzMwMjBaMA0xCzAJBgNVBAMMAkNDMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAo9U+nxksNLV5YcDNDec/Xz6+OvKGLv9crV5eS7sEEpWR0bkAVC6P97njz6g0del3zi4JvVRkEHo9hnSlOlPQaC/0fzzYP9HrgX+Z8G9Vb2cprL/d3dU0qoM57/XQV1dYFtGJlKw2G653OL+ychlEZBqfLt4eMSnGL54qCsQhVF1pIKsgcWe30f9TGHrBo2LEdgqY0T3PYVSxkRxDC0AyV68CzOzrhlz1qMitj+Ew4oNgytF+CfIyZA0rVytqAxEq6bT6BCUeB9ATRCrpfK9lX2SOU+EudwXvHAlPbngPR9dTwYtNYV5/loO0xEU2G03yUqCMT5RkqjKC8L6uvLC1mwIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQBeL/VFt2ak0mQiiQEqTMAyVQvB0NvRWcfKXC5GBYKoxaZhA4PeJNyklnbk9q+HzFi0+0SCcUlrlvmkAfIXBZburwJG/OHnPAOfmcN/hlgb3lujpEZrN28T4O/pbjgUOhiG8Xesnv+92RosDbEOcJnPHMNFsXRIuEqiJdBGE7e3B7Smv7bwmYM3WHkMo99EQ49qddxbpT1xUX2RvVHRO2hZ3WQ3cd3vTYST4TJu2jJQj4NvpKZYYZDPnaXJRsNdrtDWgFwpG1J+0m7bhbtvksQs8Uw1cBsPxdQEryAF2TZruYLGYy7OlLf+kM9yjQtHnxSPUlNNjuPsCmscWqWoifB3
f4d36e03-6a0e-4df5-9289-5f39bdb5740d	81097085-6d41-4f59-abf1-0d0f7c359645	privateKey	MIIEpAIBAAKCAQEAo9U+nxksNLV5YcDNDec/Xz6+OvKGLv9crV5eS7sEEpWR0bkAVC6P97njz6g0del3zi4JvVRkEHo9hnSlOlPQaC/0fzzYP9HrgX+Z8G9Vb2cprL/d3dU0qoM57/XQV1dYFtGJlKw2G653OL+ychlEZBqfLt4eMSnGL54qCsQhVF1pIKsgcWe30f9TGHrBo2LEdgqY0T3PYVSxkRxDC0AyV68CzOzrhlz1qMitj+Ew4oNgytF+CfIyZA0rVytqAxEq6bT6BCUeB9ATRCrpfK9lX2SOU+EudwXvHAlPbngPR9dTwYtNYV5/loO0xEU2G03yUqCMT5RkqjKC8L6uvLC1mwIDAQABAoIBAQCHXfzd7CiwbHmcoXdMU5PzGJ6JijYAwxJKVTzIif+1c0wG4zs4Uzi1USzAOZUPEBbjjvqRKxd63eXUILEc3n/GdkkokJeFM+fJGiuRlAwdfjna+LVTQ4S+lqracFryr8KjKALritcyTBdKFmpVCDeQFscMLI75xDByy9alCqUXVLmoHrg+zY9F0AXDLpjGGzn1PiCJhPkqV80RaCJm/CRXOHmlRF7oSaptqNEIHmDzolraBnGPA6zoYW2lzm6Bjhm1YOysQu9B6c9AFcG0WXv3cwbAfQCLuzX58XCyTrG3T08b6vhBhHssYnDWQ6Do6W57iVhypETw1l7xpc9NzeARAoGBAOqUtwZa93Z3HHKZKvxQDPlxNsLd+a1Yj6Upe16WIWx0NdKckJsuPhxyY5wtz6fqg1V6bdRubqK9O0tejWYUXhH3Xlgwtfq8T/6QFxTDtTflvG+7zRxCFDsAyCqdHub2vHucEPj+yQ1KCycfAsaZ55jPdRXKEXESh6cj+LKvFy91AoGBALLKz13daj3Nhk2MT5KMNVBmwTguo0SiVjeZl/ez+dWsHmK82wgmiN3Pl3+u54U733zSdWcJLdwC/0Ttmf7ToF7ByGp9BlapPmZBUv4noq/gjZsrOL42cHFRnYJBYtITZTBPfKx3tAflIvy9svTg0fszk5pRrLUuyxyC5W2aRz7PAoGBAKZ8r71Z+IHinZUT8jcq1VqAKH57LoYB8cklvMJvyP8BJ2X36oXIdxqXcOzacqPZRCb5glOfoPPtW9TtIWvOjskviI0M3Us8NYYVW9xH3ijy6x9d6X/hwhvyPR5JbzI68aDFLiKaKbU91NaKIt0zQ/TnYFD7ng9jOFW+qPagX9M1AoGADtaUFScuDQkEj2UIqZHnTs/oU0BTnnuWijC+Evmlz1zkfK9NwkRocXgsC5W5cy4/4v0Ybz+sxaieBNtvP13S3mpYtrW/k+uh2RysxZkGgHAzcGBK6kZcWJs8ZjYE/IhNio/eOfYJQ+p5V95qfrY11xI1usXyfmruwmP+pHT8WrMCgYA9SZlC4IHNZXGlPilpjSclINCb3mwzOffGsN0AvwWE+4zHjOcKyhoLcp8jrBEgDk7R42sI2d41ep8pnTvD2ftxMYxntegoaPIBYP42Tp12oQbcCrIUnc4AlOSs1+sqQOnsM8QHB8E2oVgLr+5uud5OjH1SHGOTuPpzm3WX0VpLEw==
07ac9fb6-68b7-45cb-9b7c-263193e044dd	656c891e-5ccb-4353-bf9b-a00ee88056d0	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
a3bbdaf5-e6bb-4486-ba2e-caddbe0d1112	656c891e-5ccb-4353-bf9b-a00ee88056d0	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
178f6581-2d2d-4615-adb9-9b69fb386bd9	656c891e-5ccb-4353-bf9b-a00ee88056d0	allowed-protocol-mapper-types	saml-role-list-mapper
ec4c7d3d-599e-4f39-9b34-4b1c3b3fc8ed	656c891e-5ccb-4353-bf9b-a00ee88056d0	allowed-protocol-mapper-types	saml-user-property-mapper
2f3b221c-14e5-49e1-ba4c-b80836999ee4	656c891e-5ccb-4353-bf9b-a00ee88056d0	allowed-protocol-mapper-types	oidc-address-mapper
33f60f37-72bd-4e15-9235-40f0a0f9528a	656c891e-5ccb-4353-bf9b-a00ee88056d0	allowed-protocol-mapper-types	oidc-full-name-mapper
7fe35dc8-f7b4-44b9-be88-0e7243865386	656c891e-5ccb-4353-bf9b-a00ee88056d0	allowed-protocol-mapper-types	saml-user-attribute-mapper
e88a6bfc-76cc-427e-b8d8-c6bce90ae00b	656c891e-5ccb-4353-bf9b-a00ee88056d0	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
16c4dd3d-06c1-4092-babf-f0ff6c1a5a42	27629b00-7708-44c4-a23b-87004e319759	client-uris-must-match	true
93df48c4-ee0e-46e4-9e46-c3773b4ff7b9	27629b00-7708-44c4-a23b-87004e319759	host-sending-registration-request-must-match	true
8c1adc4d-af7e-466e-a10e-3a956299235c	d02da4f3-e1ae-4499-9fb7-3b87effdfc6d	algorithm	HS256
5bd73029-37e7-4af8-a0f8-a782c86f059d	d02da4f3-e1ae-4499-9fb7-3b87effdfc6d	priority	100
6da5dccc-be7f-4757-8770-e8ea0942442c	d02da4f3-e1ae-4499-9fb7-3b87effdfc6d	secret	xt4Y2kPVPBUZt7hbqTRUes_mrqJhUNhME7SxCvJ8ld73j_dlpof3RI2VcN2j6P0ALO6GXRFv1iSJhG5b4J6z7A
60c1f2fb-3539-47cb-b667-fdc87bc3dd11	d02da4f3-e1ae-4499-9fb7-3b87effdfc6d	kid	da86422c-d02b-4419-936b-5853b1f4a71e
b0235a9c-c15d-49fa-9395-608c704cf409	e6cba7a8-9e08-48ff-b512-e55270fe383f	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
d664cf7e-7bd8-4c17-a252-720db714f017	e6cba7a8-9e08-48ff-b512-e55270fe383f	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
0f00a279-3889-4dc6-9c51-e8aa1d250ea6	e6cba7a8-9e08-48ff-b512-e55270fe383f	allowed-protocol-mapper-types	saml-role-list-mapper
76eaa28b-8f93-47d2-8ff3-d90cd20f269f	e6cba7a8-9e08-48ff-b512-e55270fe383f	allowed-protocol-mapper-types	oidc-full-name-mapper
365eb054-007e-48bc-ba21-d2c82be1003c	e6cba7a8-9e08-48ff-b512-e55270fe383f	allowed-protocol-mapper-types	saml-user-property-mapper
6b6e4f23-72f1-481b-926f-38d82d11e1cb	e6cba7a8-9e08-48ff-b512-e55270fe383f	allowed-protocol-mapper-types	saml-user-attribute-mapper
e5292ca0-2316-453d-adf2-c1aa7c550070	e6cba7a8-9e08-48ff-b512-e55270fe383f	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
3109c87a-1e6d-44c5-92ee-ae47527ab975	e6cba7a8-9e08-48ff-b512-e55270fe383f	allowed-protocol-mapper-types	oidc-address-mapper
8c8d813a-9874-43d7-a44d-21355dfc5175	2d51c5b8-5627-4412-a8a0-75d1484deed2	allow-default-scopes	true
\.


--
-- TOC entry 4143 (class 0 OID 42785)
-- Dependencies: 234
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.composite_role (composite, child_role) FROM stdin;
017a5b0c-2639-4149-9f37-9452dc8ff121	03653e68-987a-461a-98f0-dc5b5697d4f8
017a5b0c-2639-4149-9f37-9452dc8ff121	5c62bb2b-1554-43cd-a3cc-01d70671ae31
017a5b0c-2639-4149-9f37-9452dc8ff121	8663ca4f-7d33-44e4-b984-977c0882e370
017a5b0c-2639-4149-9f37-9452dc8ff121	b38b61c0-8cd6-45e2-899c-e5d7002fd0fb
017a5b0c-2639-4149-9f37-9452dc8ff121	35af9fee-883b-49e0-aecc-99e50e928706
017a5b0c-2639-4149-9f37-9452dc8ff121	9bf3804f-b98e-49ba-a2ed-907c0b524aab
017a5b0c-2639-4149-9f37-9452dc8ff121	1dda6964-37ea-4810-b12d-97404b57b29e
017a5b0c-2639-4149-9f37-9452dc8ff121	3b670222-d779-4ff8-903d-9afb1656af29
017a5b0c-2639-4149-9f37-9452dc8ff121	ec64ddc6-e9d9-4193-a3a7-46fc8061f3bb
017a5b0c-2639-4149-9f37-9452dc8ff121	e598fbc0-71e3-4c97-ac95-4ef9970d3e27
017a5b0c-2639-4149-9f37-9452dc8ff121	d1313c09-76ed-47ce-8373-344c294e6e8c
017a5b0c-2639-4149-9f37-9452dc8ff121	66933c19-d759-4b02-a1c7-128830d7ccb1
017a5b0c-2639-4149-9f37-9452dc8ff121	3f5d04c0-caa9-4904-a5f2-563c550dff69
017a5b0c-2639-4149-9f37-9452dc8ff121	cb7887e4-1659-4388-a935-fb0842983222
017a5b0c-2639-4149-9f37-9452dc8ff121	1ce1958d-9113-42e7-876b-2d2e9628bbab
017a5b0c-2639-4149-9f37-9452dc8ff121	20a8ba51-5dd7-4e8c-af18-e67fbce6a31c
017a5b0c-2639-4149-9f37-9452dc8ff121	d29d1c3f-d6f4-48d0-bd8c-dffb9b20e140
017a5b0c-2639-4149-9f37-9452dc8ff121	b0086f06-4515-4846-8912-0cc4f573caf0
35af9fee-883b-49e0-aecc-99e50e928706	20a8ba51-5dd7-4e8c-af18-e67fbce6a31c
b38b61c0-8cd6-45e2-899c-e5d7002fd0fb	b0086f06-4515-4846-8912-0cc4f573caf0
b38b61c0-8cd6-45e2-899c-e5d7002fd0fb	1ce1958d-9113-42e7-876b-2d2e9628bbab
4a924ab3-e9d2-45af-9730-1723081a34d5	38d4387e-6fe9-4076-9e4d-86a922d08a82
4a924ab3-e9d2-45af-9730-1723081a34d5	f236e675-8505-423f-9cdd-b3f063b15572
f236e675-8505-423f-9cdd-b3f063b15572	aa5b722c-cf57-4946-b0ff-36aeb6862319
6f58783a-ce0d-4e45-b3e0-6f2c0391e26b	18769953-dfd0-49f0-958a-94e149a4763d
017a5b0c-2639-4149-9f37-9452dc8ff121	0f376d37-89a0-4540-9e39-e37ae69a9cf3
4a924ab3-e9d2-45af-9730-1723081a34d5	802aa55a-b52a-435a-bff2-4a3401cff9bd
4a924ab3-e9d2-45af-9730-1723081a34d5	77f1c4c6-7bb0-43d5-b5ad-6800b6bab22a
017a5b0c-2639-4149-9f37-9452dc8ff121	9ed10135-303a-485d-a507-e0764bead5a9
017a5b0c-2639-4149-9f37-9452dc8ff121	36e92b10-c2f9-43e0-91fb-ee5b20fdda30
017a5b0c-2639-4149-9f37-9452dc8ff121	0bae53b2-7d54-49eb-908f-60ca0a3ecf6f
017a5b0c-2639-4149-9f37-9452dc8ff121	fa5ce6b3-c46e-443f-a2b2-f4f349594c12
017a5b0c-2639-4149-9f37-9452dc8ff121	f6bd5f7a-2b67-4ac1-aa32-2cf892539139
017a5b0c-2639-4149-9f37-9452dc8ff121	ee09dba0-9d0a-4f89-af06-93f8fd7b2964
017a5b0c-2639-4149-9f37-9452dc8ff121	4bc72d19-deb6-4cce-9c6c-d197904b664c
017a5b0c-2639-4149-9f37-9452dc8ff121	947defc3-fa95-42df-8edc-7f071f425c93
017a5b0c-2639-4149-9f37-9452dc8ff121	929a7669-0565-464a-b482-91526562eec2
017a5b0c-2639-4149-9f37-9452dc8ff121	1522f852-b753-416a-ba0e-a4e92024f4f0
017a5b0c-2639-4149-9f37-9452dc8ff121	794fa740-043c-4d69-9562-1f5bbf011478
017a5b0c-2639-4149-9f37-9452dc8ff121	0a84c669-db58-4e0b-a576-0f5d311b41d7
017a5b0c-2639-4149-9f37-9452dc8ff121	eeba9077-911f-488f-9e0b-af912c1e5208
017a5b0c-2639-4149-9f37-9452dc8ff121	e4483143-e154-4e9b-b83a-9c5b43880333
017a5b0c-2639-4149-9f37-9452dc8ff121	c557e233-a735-42aa-a9c0-2f7819c8ed67
017a5b0c-2639-4149-9f37-9452dc8ff121	d5e16403-89c5-4a5b-a838-5d36968db6c6
017a5b0c-2639-4149-9f37-9452dc8ff121	a119d61b-8890-4053-8544-5b5c11303a40
fa5ce6b3-c46e-443f-a2b2-f4f349594c12	c557e233-a735-42aa-a9c0-2f7819c8ed67
0bae53b2-7d54-49eb-908f-60ca0a3ecf6f	a119d61b-8890-4053-8544-5b5c11303a40
0bae53b2-7d54-49eb-908f-60ca0a3ecf6f	e4483143-e154-4e9b-b83a-9c5b43880333
64c8f33d-3a88-47d5-ae85-e7709b3c92bf	008360b3-9666-404c-a2ad-788147654cac
64c8f33d-3a88-47d5-ae85-e7709b3c92bf	ace9a4e6-d3d9-4c51-8c24-2ec63a4d1f52
64c8f33d-3a88-47d5-ae85-e7709b3c92bf	5305ce79-6358-4391-99b7-9cd6a06429a4
64c8f33d-3a88-47d5-ae85-e7709b3c92bf	f2b7512e-6080-41be-ad38-46292cb9061e
05c89a52-239d-45ba-b644-491bc6a97b10	83c9992d-55a4-4588-8cfb-8349167a6d7e
d234085f-4360-4df2-881e-d28730a1d47a	96fcc8f8-c9fc-4fb5-96ec-4207aacad947
d234085f-4360-4df2-881e-d28730a1d47a	5db7a446-8b92-4d12-b928-42b387220c63
8c7bebbb-5060-40b1-95d3-fd4219296dd9	05c89a52-239d-45ba-b644-491bc6a97b10
8c7bebbb-5060-40b1-95d3-fd4219296dd9	96fcc8f8-c9fc-4fb5-96ec-4207aacad947
8c7bebbb-5060-40b1-95d3-fd4219296dd9	8e70c551-ae07-46d2-84a4-a295447c2869
8c7bebbb-5060-40b1-95d3-fd4219296dd9	5db7a446-8b92-4d12-b928-42b387220c63
8c7bebbb-5060-40b1-95d3-fd4219296dd9	35153be4-77dd-4ce1-b779-f6218e2b3a89
8c7bebbb-5060-40b1-95d3-fd4219296dd9	7863bc9a-df8c-4ee6-ad55-28ce5fd734ba
8c7bebbb-5060-40b1-95d3-fd4219296dd9	b73c1b8a-4755-47f0-af12-8c917fffeda7
8c7bebbb-5060-40b1-95d3-fd4219296dd9	fa453334-d981-4997-9815-390e2564a8b5
8c7bebbb-5060-40b1-95d3-fd4219296dd9	d234085f-4360-4df2-881e-d28730a1d47a
8c7bebbb-5060-40b1-95d3-fd4219296dd9	c8081ddd-a50b-460c-ae4e-aa93b043594a
8c7bebbb-5060-40b1-95d3-fd4219296dd9	b4e94c7e-2bfa-436c-b967-1e0060018b60
8c7bebbb-5060-40b1-95d3-fd4219296dd9	a7ab5d31-0388-46ca-9ac0-30002f493981
8c7bebbb-5060-40b1-95d3-fd4219296dd9	ad7221e6-5a5e-48ec-9695-6d4299afdfc7
8c7bebbb-5060-40b1-95d3-fd4219296dd9	3213f038-f1e6-46a7-a719-2bd956751c0d
8c7bebbb-5060-40b1-95d3-fd4219296dd9	eb7fc4c4-6f74-4539-a929-d6df8ece2ca6
8c7bebbb-5060-40b1-95d3-fd4219296dd9	28f37dc9-4a17-489f-8a58-b998b5791583
8c7bebbb-5060-40b1-95d3-fd4219296dd9	44f9a8ab-add5-4a9d-985a-db30e70fa3cf
8c7bebbb-5060-40b1-95d3-fd4219296dd9	83c9992d-55a4-4588-8cfb-8349167a6d7e
ace9a4e6-d3d9-4c51-8c24-2ec63a4d1f52	8f504e9b-11d3-4744-b255-ce11f249e9e2
aa5e4901-3930-4788-8886-6b5af219084b	1e953e82-93ba-403e-be31-42a37faec734
017a5b0c-2639-4149-9f37-9452dc8ff121	d218ac73-b8b6-443b-9481-f45bf02a7592
\.


--
-- TOC entry 4144 (class 0 OID 42788)
-- Dependencies: 235
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
6409d537-2299-4090-af4a-4ad3c92187b6	\N	password	97f3b26f-a6ee-44c9-b682-b86d0be2667e	1634204294377	\N	{"value":"EXv8qLUf0HuEnqe8LC2+XqmmJMx9UB11/EbAbDT6G0rE7nGjyqIFPbuRNkZUN6dVmiyDAy8nVTm87tfyxGiCxw==","salt":"cjwuvK1mQbwb69QeIfSLxg==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
\.


--
-- TOC entry 4145 (class 0 OID 42793)
-- Dependencies: 236
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2021-10-14 11:38:11.09485	1	EXECUTED	7:4e70412f24a3f382c82183742ec79317	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	3.5.4	\N	\N	4204290975
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2021-10-14 11:38:11.100148	2	MARK_RAN	7:cb16724583e9675711801c6875114f28	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	3.5.4	\N	\N	4204290975
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2021-10-14 11:38:11.116345	3	EXECUTED	7:0310eb8ba07cec616460794d42ade0fa	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	3.5.4	\N	\N	4204290975
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2021-10-14 11:38:11.118177	4	EXECUTED	7:5d25857e708c3233ef4439df1f93f012	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	3.5.4	\N	\N	4204290975
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2021-10-14 11:38:11.155066	5	EXECUTED	7:c7a54a1041d58eb3817a4a883b4d4e84	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	3.5.4	\N	\N	4204290975
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2021-10-14 11:38:11.157061	6	MARK_RAN	7:2e01012df20974c1c2a605ef8afe25b7	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	3.5.4	\N	\N	4204290975
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2021-10-14 11:38:11.188151	7	EXECUTED	7:0f08df48468428e0f30ee59a8ec01a41	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	3.5.4	\N	\N	4204290975
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2021-10-14 11:38:11.18986	8	MARK_RAN	7:a77ea2ad226b345e7d689d366f185c8c	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	3.5.4	\N	\N	4204290975
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2021-10-14 11:38:11.192589	9	EXECUTED	7:a3377a2059aefbf3b90ebb4c4cc8e2ab	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	3.5.4	\N	\N	4204290975
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2021-10-14 11:38:11.227791	10	EXECUTED	7:04c1dbedc2aa3e9756d1a1668e003451	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	3.5.4	\N	\N	4204290975
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2021-10-14 11:38:11.248619	11	EXECUTED	7:36ef39ed560ad07062d956db861042ba	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	4204290975
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2021-10-14 11:38:11.24974	12	MARK_RAN	7:d909180b2530479a716d3f9c9eaea3d7	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	4204290975
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2021-10-14 11:38:11.256084	13	EXECUTED	7:cf12b04b79bea5152f165eb41f3955f6	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	4204290975
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2021-10-14 11:38:11.265688	14	EXECUTED	7:7e32c8f05c755e8675764e7d5f514509	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	3.5.4	\N	\N	4204290975
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2021-10-14 11:38:11.266629	15	MARK_RAN	7:980ba23cc0ec39cab731ce903dd01291	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	4204290975
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2021-10-14 11:38:11.267531	16	MARK_RAN	7:2fa220758991285312eb84f3b4ff5336	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	3.5.4	\N	\N	4204290975
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2021-10-14 11:38:11.268325	17	EXECUTED	7:d41d8cd98f00b204e9800998ecf8427e	empty		\N	3.5.4	\N	\N	4204290975
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2021-10-14 11:38:11.290275	18	EXECUTED	7:91ace540896df890cc00a0490ee52bbc	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	3.5.4	\N	\N	4204290975
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2021-10-14 11:38:11.307138	19	EXECUTED	7:c31d1646dfa2618a9335c00e07f89f24	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	3.5.4	\N	\N	4204290975
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2021-10-14 11:38:11.309418	20	EXECUTED	7:df8bc21027a4f7cbbb01f6344e89ce07	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	3.5.4	\N	\N	4204290975
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2021-10-14 11:38:11.83148	45	EXECUTED	7:6a48ce645a3525488a90fbf76adf3bb3	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	3.5.4	\N	\N	4204290975
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2021-10-14 11:38:11.310411	21	MARK_RAN	7:f987971fe6b37d963bc95fee2b27f8df	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	3.5.4	\N	\N	4204290975
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2021-10-14 11:38:11.311632	22	MARK_RAN	7:df8bc21027a4f7cbbb01f6344e89ce07	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	3.5.4	\N	\N	4204290975
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2021-10-14 11:38:11.329772	23	EXECUTED	7:ed2dc7f799d19ac452cbcda56c929e47	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	3.5.4	\N	\N	4204290975
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2021-10-14 11:38:11.332052	24	EXECUTED	7:80b5db88a5dda36ece5f235be8757615	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	3.5.4	\N	\N	4204290975
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2021-10-14 11:38:11.332798	25	MARK_RAN	7:1437310ed1305a9b93f8848f301726ce	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	3.5.4	\N	\N	4204290975
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2021-10-14 11:38:11.410913	26	EXECUTED	7:b82ffb34850fa0836be16deefc6a87c4	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	3.5.4	\N	\N	4204290975
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2021-10-14 11:38:11.441743	27	EXECUTED	7:9cc98082921330d8d9266decdd4bd658	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	3.5.4	\N	\N	4204290975
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2021-10-14 11:38:11.445321	28	EXECUTED	7:03d64aeed9cb52b969bd30a7ac0db57e	update tableName=RESOURCE_SERVER_POLICY		\N	3.5.4	\N	\N	4204290975
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2021-10-14 11:38:11.473663	29	EXECUTED	7:f1f9fd8710399d725b780f463c6b21cd	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	3.5.4	\N	\N	4204290975
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2021-10-14 11:38:11.478313	30	EXECUTED	7:53188c3eb1107546e6f765835705b6c1	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	3.5.4	\N	\N	4204290975
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2021-10-14 11:38:11.484812	31	EXECUTED	7:d6e6f3bc57a0c5586737d1351725d4d4	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	3.5.4	\N	\N	4204290975
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2021-10-14 11:38:11.48647	32	EXECUTED	7:454d604fbd755d9df3fd9c6329043aa5	customChange		\N	3.5.4	\N	\N	4204290975
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2021-10-14 11:38:11.488288	33	EXECUTED	7:57e98a3077e29caf562f7dbf80c72600	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	4204290975
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2021-10-14 11:38:11.489172	34	MARK_RAN	7:e4c7e8f2256210aee71ddc42f538b57a	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	3.5.4	\N	\N	4204290975
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2021-10-14 11:38:11.499071	35	EXECUTED	7:09a43c97e49bc626460480aa1379b522	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	3.5.4	\N	\N	4204290975
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2021-10-14 11:38:11.500766	36	EXECUTED	7:26bfc7c74fefa9126f2ce702fb775553	addColumn tableName=REALM		\N	3.5.4	\N	\N	4204290975
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2021-10-14 11:38:11.502916	37	EXECUTED	7:a161e2ae671a9020fff61e996a207377	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	4204290975
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2021-10-14 11:38:11.504066	38	EXECUTED	7:37fc1781855ac5388c494f1442b3f717	addColumn tableName=FED_USER_CONSENT		\N	3.5.4	\N	\N	4204290975
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2021-10-14 11:38:11.505196	39	EXECUTED	7:13a27db0dae6049541136adad7261d27	addColumn tableName=IDENTITY_PROVIDER		\N	3.5.4	\N	\N	4204290975
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2021-10-14 11:38:11.505868	40	MARK_RAN	7:550300617e3b59e8af3a6294df8248a3	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	3.5.4	\N	\N	4204290975
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2021-10-14 11:38:11.506609	41	MARK_RAN	7:e3a9482b8931481dc2772a5c07c44f17	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	3.5.4	\N	\N	4204290975
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2021-10-14 11:38:11.508308	42	EXECUTED	7:72b07d85a2677cb257edb02b408f332d	customChange		\N	3.5.4	\N	\N	4204290975
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2021-10-14 11:38:11.827505	43	EXECUTED	7:a72a7858967bd414835d19e04d880312	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	3.5.4	\N	\N	4204290975
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2021-10-14 11:38:11.829774	44	EXECUTED	7:94edff7cf9ce179e7e85f0cd78a3cf2c	addColumn tableName=USER_ENTITY		\N	3.5.4	\N	\N	4204290975
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2021-10-14 11:38:11.833674	46	EXECUTED	7:e64b5dcea7db06077c6e57d3b9e5ca14	customChange		\N	3.5.4	\N	\N	4204290975
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2021-10-14 11:38:11.834601	47	MARK_RAN	7:fd8cf02498f8b1e72496a20afc75178c	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	3.5.4	\N	\N	4204290975
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2021-10-14 11:38:11.863323	48	EXECUTED	7:542794f25aa2b1fbabb7e577d6646319	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	3.5.4	\N	\N	4204290975
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2021-10-14 11:38:11.865092	49	EXECUTED	7:edad604c882df12f74941dac3cc6d650	addColumn tableName=REALM		\N	3.5.4	\N	\N	4204290975
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2021-10-14 11:38:11.881634	50	EXECUTED	7:0f88b78b7b46480eb92690cbf5e44900	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	3.5.4	\N	\N	4204290975
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2021-10-14 11:38:11.956287	51	EXECUTED	7:d560e43982611d936457c327f872dd59	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	3.5.4	\N	\N	4204290975
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2021-10-14 11:38:11.957706	52	EXECUTED	7:c155566c42b4d14ef07059ec3b3bbd8e	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	4204290975
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2021-10-14 11:38:11.960157	53	EXECUTED	7:b40376581f12d70f3c89ba8ddf5b7dea	update tableName=REALM		\N	3.5.4	\N	\N	4204290975
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2021-10-14 11:38:11.961402	54	EXECUTED	7:a1132cc395f7b95b3646146c2e38f168	update tableName=CLIENT		\N	3.5.4	\N	\N	4204290975
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2021-10-14 11:38:11.966358	55	EXECUTED	7:d8dc5d89c789105cfa7ca0e82cba60af	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	3.5.4	\N	\N	4204290975
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2021-10-14 11:38:11.968368	56	EXECUTED	7:7822e0165097182e8f653c35517656a3	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	3.5.4	\N	\N	4204290975
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2021-10-14 11:38:11.981662	57	EXECUTED	7:c6538c29b9c9a08f9e9ea2de5c2b6375	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	3.5.4	\N	\N	4204290975
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2021-10-14 11:38:12.067685	58	EXECUTED	7:6d4893e36de22369cf73bcb051ded875	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	3.5.4	\N	\N	4204290975
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2021-10-14 11:38:12.078775	59	EXECUTED	7:57960fc0b0f0dd0563ea6f8b2e4a1707	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	3.5.4	\N	\N	4204290975
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2021-10-14 11:38:12.081075	60	EXECUTED	7:2b4b8bff39944c7097977cc18dbceb3b	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	3.5.4	\N	\N	4204290975
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2021-10-14 11:38:12.084049	61	EXECUTED	7:2aa42a964c59cd5b8ca9822340ba33a8	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	3.5.4	\N	\N	4204290975
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2021-10-14 11:38:12.086119	62	EXECUTED	7:9ac9e58545479929ba23f4a3087a0346	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	3.5.4	\N	\N	4204290975
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2021-10-14 11:38:12.087391	63	EXECUTED	7:14d407c35bc4fe1976867756bcea0c36	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	3.5.4	\N	\N	4204290975
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2021-10-14 11:38:12.088465	64	EXECUTED	7:241a8030c748c8548e346adee548fa93	update tableName=REQUIRED_ACTION_PROVIDER		\N	3.5.4	\N	\N	4204290975
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2021-10-14 11:38:12.08947	65	EXECUTED	7:7d3182f65a34fcc61e8d23def037dc3f	update tableName=RESOURCE_SERVER_RESOURCE		\N	3.5.4	\N	\N	4204290975
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2021-10-14 11:38:12.098553	66	EXECUTED	7:b30039e00a0b9715d430d1b0636728fa	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	3.5.4	\N	\N	4204290975
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2021-10-14 11:38:12.104587	67	EXECUTED	7:3797315ca61d531780f8e6f82f258159	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	3.5.4	\N	\N	4204290975
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2021-10-14 11:38:12.106172	68	EXECUTED	7:c7aa4c8d9573500c2d347c1941ff0301	addColumn tableName=REALM		\N	3.5.4	\N	\N	4204290975
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2021-10-14 11:38:12.113525	69	EXECUTED	7:b207faee394fc074a442ecd42185a5dd	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	3.5.4	\N	\N	4204290975
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2021-10-14 11:38:12.115308	70	EXECUTED	7:ab9a9762faaba4ddfa35514b212c4922	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	3.5.4	\N	\N	4204290975
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2021-10-14 11:38:12.116795	71	EXECUTED	7:b9710f74515a6ccb51b72dc0d19df8c4	addColumn tableName=RESOURCE_SERVER		\N	3.5.4	\N	\N	4204290975
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2021-10-14 11:38:12.119047	72	EXECUTED	7:ec9707ae4d4f0b7452fee20128083879	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	4204290975
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2021-10-14 11:38:12.121333	73	EXECUTED	7:3979a0ae07ac465e920ca696532fc736	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	4204290975
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2021-10-14 11:38:12.122056	74	MARK_RAN	7:5abfde4c259119d143bd2fbf49ac2bca	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	4204290975
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2021-10-14 11:38:12.128053	75	EXECUTED	7:b48da8c11a3d83ddd6b7d0c8c2219345	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	3.5.4	\N	\N	4204290975
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2021-10-14 11:38:12.134686	76	EXECUTED	7:a73379915c23bfad3e8f5c6d5c0aa4bd	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	3.5.4	\N	\N	4204290975
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2021-10-14 11:38:12.135778	77	EXECUTED	7:39e0073779aba192646291aa2332493d	addColumn tableName=CLIENT		\N	3.5.4	\N	\N	4204290975
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2021-10-14 11:38:12.136403	78	MARK_RAN	7:81f87368f00450799b4bf42ea0b3ec34	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	3.5.4	\N	\N	4204290975
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2021-10-14 11:38:12.143002	79	EXECUTED	7:20b37422abb9fb6571c618148f013a15	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	3.5.4	\N	\N	4204290975
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2021-10-14 11:38:12.143792	80	MARK_RAN	7:1970bb6cfb5ee800736b95ad3fb3c78a	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	3.5.4	\N	\N	4204290975
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2021-10-14 11:38:12.149999	81	EXECUTED	7:45d9b25fc3b455d522d8dcc10a0f4c80	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	3.5.4	\N	\N	4204290975
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2021-10-14 11:38:12.150868	82	MARK_RAN	7:890ae73712bc187a66c2813a724d037f	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	4204290975
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2021-10-14 11:38:12.152429	83	EXECUTED	7:0a211980d27fafe3ff50d19a3a29b538	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	4204290975
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2021-10-14 11:38:12.153153	84	MARK_RAN	7:a161e2ae671a9020fff61e996a207377	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	4204290975
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2021-10-14 11:38:12.160652	85	EXECUTED	7:01c49302201bdf815b0a18d1f98a55dc	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	3.5.4	\N	\N	4204290975
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2021-10-14 11:38:12.163324	86	EXECUTED	7:3dace6b144c11f53f1ad2c0361279b86	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	3.5.4	\N	\N	4204290975
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2021-10-14 11:38:12.165709	87	EXECUTED	7:578d0b92077eaf2ab95ad0ec087aa903	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	3.5.4	\N	\N	4204290975
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2021-10-14 11:38:12.169746	88	EXECUTED	7:c95abe90d962c57a09ecaee57972835d	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	3.5.4	\N	\N	4204290975
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-10-14 11:38:12.17207	89	EXECUTED	7:f1313bcc2994a5c4dc1062ed6d8282d3	addColumn tableName=REALM; customChange		\N	3.5.4	\N	\N	4204290975
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-10-14 11:38:12.17485	90	EXECUTED	7:90d763b52eaffebefbcbde55f269508b	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	3.5.4	\N	\N	4204290975
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-10-14 11:38:12.184456	91	EXECUTED	7:d554f0cb92b764470dccfa5e0014a7dd	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	4204290975
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-10-14 11:38:12.187102	92	EXECUTED	7:73193e3ab3c35cf0f37ccea3bf783764	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	3.5.4	\N	\N	4204290975
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-10-14 11:38:12.187831	93	MARK_RAN	7:90a1e74f92e9cbaa0c5eab80b8a037f3	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	3.5.4	\N	\N	4204290975
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-10-14 11:38:12.191493	94	EXECUTED	7:5b9248f29cd047c200083cc6d8388b16	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	3.5.4	\N	\N	4204290975
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-10-14 11:38:12.192428	95	MARK_RAN	7:64db59e44c374f13955489e8990d17a1	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	3.5.4	\N	\N	4204290975
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-10-14 11:38:12.196621	96	EXECUTED	7:329a578cdb43262fff975f0a7f6cda60	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	3.5.4	\N	\N	4204290975
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2021-10-14 11:38:12.214727	97	EXECUTED	7:fae0de241ac0fd0bbc2b380b85e4f567	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	4204290975
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2021-10-14 11:38:12.220657	98	EXECUTED	7:075d54e9180f49bb0c64ca4218936e81	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	4204290975
14.0.0-KEYCLOAK-18286-mysql	keycloak	META-INF/jpa-changelog-14.0.0.xml	2021-10-14 11:38:12.22137	99	MARK_RAN	7:b558ad47ea0e4d3c3514225a49cc0d65	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	4204290975
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2021-10-14 11:38:12.226842	100	EXECUTED	7:1a7f28ff8d9e53aeb879d76ea3d9341a	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	3.5.4	\N	\N	4204290975
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2021-10-14 11:38:12.228359	101	EXECUTED	7:2fd554456fed4a82c698c555c5b751b6	customChange		\N	3.5.4	\N	\N	4204290975
\.


--
-- TOC entry 4146 (class 0 OID 42798)
-- Dependencies: 237
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
1001	f	\N	\N
\.


--
-- TOC entry 4147 (class 0 OID 42801)
-- Dependencies: 238
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
master	4af24db3-e37c-4cd7-b7b6-6ebd90e552fe	f
master	1fbbf0e1-c81a-4757-90d1-a8b65a6eac26	t
master	dc6899d1-5be4-40c7-8664-7baf2178f8be	t
master	20831ba4-8f6e-41c9-8f1e-e625242a8e0c	t
master	73953e93-d388-40b3-85cc-d2ebc1f6fbb0	f
master	d7691612-6a6a-4ddd-a188-ddbfadfb8a9c	f
master	33e00a2e-fadf-4389-a762-0118a9c1badb	t
master	309eaf84-3a62-41cd-82b6-65ca26f3a731	t
master	9d2741a0-6c1f-41fd-b8ef-76e99a594225	f
CC	fc4ba834-d258-4deb-9b04-5dac5518559a	t
CC	13ac6628-4572-4335-a50c-2761c21c3cc0	t
CC	0fb0feeb-c8d3-4a65-889d-fd69ce493eab	t
CC	708c7fd8-1731-4cf9-8ea2-5b3bb57d65d6	t
CC	323bbbd8-2c6c-4080-a351-7f4cf8fd42b2	t
CC	c15c5363-490a-48d2-9edf-b12d8669b7cf	f
CC	4cf73263-9888-43d5-af5b-fc70ea4b99be	f
CC	72d38159-ce38-477d-b26a-695d1be288d8	f
CC	bcca4bf3-80df-4c1c-9394-36b7263928b8	f
\.


--
-- TOC entry 4148 (class 0 OID 42805)
-- Dependencies: 239
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id) FROM stdin;
\.


--
-- TOC entry 4149 (class 0 OID 42810)
-- Dependencies: 240
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value) FROM stdin;
\.


--
-- TOC entry 4150 (class 0 OID 42815)
-- Dependencies: 241
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- TOC entry 4151 (class 0 OID 42820)
-- Dependencies: 242
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- TOC entry 4152 (class 0 OID 42823)
-- Dependencies: 243
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- TOC entry 4153 (class 0 OID 42828)
-- Dependencies: 244
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- TOC entry 4154 (class 0 OID 42831)
-- Dependencies: 245
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- TOC entry 4155 (class 0 OID 42837)
-- Dependencies: 246
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- TOC entry 4156 (class 0 OID 42840)
-- Dependencies: 247
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- TOC entry 4157 (class 0 OID 42845)
-- Dependencies: 248
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- TOC entry 4158 (class 0 OID 42850)
-- Dependencies: 249
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- TOC entry 4159 (class 0 OID 42856)
-- Dependencies: 250
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- TOC entry 4160 (class 0 OID 42859)
-- Dependencies: 251
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
\.


--
-- TOC entry 4161 (class 0 OID 42870)
-- Dependencies: 252
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- TOC entry 4162 (class 0 OID 42875)
-- Dependencies: 253
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- TOC entry 4163 (class 0 OID 42880)
-- Dependencies: 254
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- TOC entry 4164 (class 0 OID 42885)
-- Dependencies: 255
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
1b5c0d65-8666-4805-b046-d2adbac999d3	REGISTERED_USER	 	CC
\.


--
-- TOC entry 4165 (class 0 OID 42888)
-- Dependencies: 256
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
4a924ab3-e9d2-45af-9730-1723081a34d5	master	f	${role_default-roles}	default-roles-master	master	\N	\N
017a5b0c-2639-4149-9f37-9452dc8ff121	master	f	${role_admin}	admin	master	\N	\N
03653e68-987a-461a-98f0-dc5b5697d4f8	master	f	${role_create-realm}	create-realm	master	\N	\N
5c62bb2b-1554-43cd-a3cc-01d70671ae31	afddb56d-0c09-4bb5-ba70-3d594f19d404	t	${role_create-client}	create-client	master	afddb56d-0c09-4bb5-ba70-3d594f19d404	\N
8663ca4f-7d33-44e4-b984-977c0882e370	afddb56d-0c09-4bb5-ba70-3d594f19d404	t	${role_view-realm}	view-realm	master	afddb56d-0c09-4bb5-ba70-3d594f19d404	\N
b38b61c0-8cd6-45e2-899c-e5d7002fd0fb	afddb56d-0c09-4bb5-ba70-3d594f19d404	t	${role_view-users}	view-users	master	afddb56d-0c09-4bb5-ba70-3d594f19d404	\N
35af9fee-883b-49e0-aecc-99e50e928706	afddb56d-0c09-4bb5-ba70-3d594f19d404	t	${role_view-clients}	view-clients	master	afddb56d-0c09-4bb5-ba70-3d594f19d404	\N
9bf3804f-b98e-49ba-a2ed-907c0b524aab	afddb56d-0c09-4bb5-ba70-3d594f19d404	t	${role_view-events}	view-events	master	afddb56d-0c09-4bb5-ba70-3d594f19d404	\N
1dda6964-37ea-4810-b12d-97404b57b29e	afddb56d-0c09-4bb5-ba70-3d594f19d404	t	${role_view-identity-providers}	view-identity-providers	master	afddb56d-0c09-4bb5-ba70-3d594f19d404	\N
3b670222-d779-4ff8-903d-9afb1656af29	afddb56d-0c09-4bb5-ba70-3d594f19d404	t	${role_view-authorization}	view-authorization	master	afddb56d-0c09-4bb5-ba70-3d594f19d404	\N
ec64ddc6-e9d9-4193-a3a7-46fc8061f3bb	afddb56d-0c09-4bb5-ba70-3d594f19d404	t	${role_manage-realm}	manage-realm	master	afddb56d-0c09-4bb5-ba70-3d594f19d404	\N
e598fbc0-71e3-4c97-ac95-4ef9970d3e27	afddb56d-0c09-4bb5-ba70-3d594f19d404	t	${role_manage-users}	manage-users	master	afddb56d-0c09-4bb5-ba70-3d594f19d404	\N
d1313c09-76ed-47ce-8373-344c294e6e8c	afddb56d-0c09-4bb5-ba70-3d594f19d404	t	${role_manage-clients}	manage-clients	master	afddb56d-0c09-4bb5-ba70-3d594f19d404	\N
66933c19-d759-4b02-a1c7-128830d7ccb1	afddb56d-0c09-4bb5-ba70-3d594f19d404	t	${role_manage-events}	manage-events	master	afddb56d-0c09-4bb5-ba70-3d594f19d404	\N
3f5d04c0-caa9-4904-a5f2-563c550dff69	afddb56d-0c09-4bb5-ba70-3d594f19d404	t	${role_manage-identity-providers}	manage-identity-providers	master	afddb56d-0c09-4bb5-ba70-3d594f19d404	\N
cb7887e4-1659-4388-a935-fb0842983222	afddb56d-0c09-4bb5-ba70-3d594f19d404	t	${role_manage-authorization}	manage-authorization	master	afddb56d-0c09-4bb5-ba70-3d594f19d404	\N
1ce1958d-9113-42e7-876b-2d2e9628bbab	afddb56d-0c09-4bb5-ba70-3d594f19d404	t	${role_query-users}	query-users	master	afddb56d-0c09-4bb5-ba70-3d594f19d404	\N
20a8ba51-5dd7-4e8c-af18-e67fbce6a31c	afddb56d-0c09-4bb5-ba70-3d594f19d404	t	${role_query-clients}	query-clients	master	afddb56d-0c09-4bb5-ba70-3d594f19d404	\N
d29d1c3f-d6f4-48d0-bd8c-dffb9b20e140	afddb56d-0c09-4bb5-ba70-3d594f19d404	t	${role_query-realms}	query-realms	master	afddb56d-0c09-4bb5-ba70-3d594f19d404	\N
b0086f06-4515-4846-8912-0cc4f573caf0	afddb56d-0c09-4bb5-ba70-3d594f19d404	t	${role_query-groups}	query-groups	master	afddb56d-0c09-4bb5-ba70-3d594f19d404	\N
38d4387e-6fe9-4076-9e4d-86a922d08a82	df754331-dc4c-4886-aa39-4a7ac747b383	t	${role_view-profile}	view-profile	master	df754331-dc4c-4886-aa39-4a7ac747b383	\N
f236e675-8505-423f-9cdd-b3f063b15572	df754331-dc4c-4886-aa39-4a7ac747b383	t	${role_manage-account}	manage-account	master	df754331-dc4c-4886-aa39-4a7ac747b383	\N
aa5b722c-cf57-4946-b0ff-36aeb6862319	df754331-dc4c-4886-aa39-4a7ac747b383	t	${role_manage-account-links}	manage-account-links	master	df754331-dc4c-4886-aa39-4a7ac747b383	\N
282a4b1c-56ef-4fec-8a02-09f7fb682b8b	df754331-dc4c-4886-aa39-4a7ac747b383	t	${role_view-applications}	view-applications	master	df754331-dc4c-4886-aa39-4a7ac747b383	\N
18769953-dfd0-49f0-958a-94e149a4763d	df754331-dc4c-4886-aa39-4a7ac747b383	t	${role_view-consent}	view-consent	master	df754331-dc4c-4886-aa39-4a7ac747b383	\N
6f58783a-ce0d-4e45-b3e0-6f2c0391e26b	df754331-dc4c-4886-aa39-4a7ac747b383	t	${role_manage-consent}	manage-consent	master	df754331-dc4c-4886-aa39-4a7ac747b383	\N
a10371d5-0657-4d4e-8b47-48c01a94b72f	df754331-dc4c-4886-aa39-4a7ac747b383	t	${role_delete-account}	delete-account	master	df754331-dc4c-4886-aa39-4a7ac747b383	\N
bb22488b-be19-4ea3-abf0-f35b0fcf5cef	b4c6f356-3437-48fd-9b9b-0d7a0465ae07	t	${role_read-token}	read-token	master	b4c6f356-3437-48fd-9b9b-0d7a0465ae07	\N
0f376d37-89a0-4540-9e39-e37ae69a9cf3	afddb56d-0c09-4bb5-ba70-3d594f19d404	t	${role_impersonation}	impersonation	master	afddb56d-0c09-4bb5-ba70-3d594f19d404	\N
802aa55a-b52a-435a-bff2-4a3401cff9bd	master	f	${role_offline-access}	offline_access	master	\N	\N
77f1c4c6-7bb0-43d5-b5ad-6800b6bab22a	master	f	${role_uma_authorization}	uma_authorization	master	\N	\N
64c8f33d-3a88-47d5-ae85-e7709b3c92bf	CC	f	${role_default-roles}	default-roles-mag	CC	\N	\N
9ed10135-303a-485d-a507-e0764bead5a9	56449e2a-41ae-45cd-9c21-464cbe5c43f1	t	${role_create-client}	create-client	master	56449e2a-41ae-45cd-9c21-464cbe5c43f1	\N
36e92b10-c2f9-43e0-91fb-ee5b20fdda30	56449e2a-41ae-45cd-9c21-464cbe5c43f1	t	${role_view-realm}	view-realm	master	56449e2a-41ae-45cd-9c21-464cbe5c43f1	\N
0bae53b2-7d54-49eb-908f-60ca0a3ecf6f	56449e2a-41ae-45cd-9c21-464cbe5c43f1	t	${role_view-users}	view-users	master	56449e2a-41ae-45cd-9c21-464cbe5c43f1	\N
fa5ce6b3-c46e-443f-a2b2-f4f349594c12	56449e2a-41ae-45cd-9c21-464cbe5c43f1	t	${role_view-clients}	view-clients	master	56449e2a-41ae-45cd-9c21-464cbe5c43f1	\N
f6bd5f7a-2b67-4ac1-aa32-2cf892539139	56449e2a-41ae-45cd-9c21-464cbe5c43f1	t	${role_view-events}	view-events	master	56449e2a-41ae-45cd-9c21-464cbe5c43f1	\N
ee09dba0-9d0a-4f89-af06-93f8fd7b2964	56449e2a-41ae-45cd-9c21-464cbe5c43f1	t	${role_view-identity-providers}	view-identity-providers	master	56449e2a-41ae-45cd-9c21-464cbe5c43f1	\N
4bc72d19-deb6-4cce-9c6c-d197904b664c	56449e2a-41ae-45cd-9c21-464cbe5c43f1	t	${role_view-authorization}	view-authorization	master	56449e2a-41ae-45cd-9c21-464cbe5c43f1	\N
947defc3-fa95-42df-8edc-7f071f425c93	56449e2a-41ae-45cd-9c21-464cbe5c43f1	t	${role_manage-realm}	manage-realm	master	56449e2a-41ae-45cd-9c21-464cbe5c43f1	\N
929a7669-0565-464a-b482-91526562eec2	56449e2a-41ae-45cd-9c21-464cbe5c43f1	t	${role_manage-users}	manage-users	master	56449e2a-41ae-45cd-9c21-464cbe5c43f1	\N
1522f852-b753-416a-ba0e-a4e92024f4f0	56449e2a-41ae-45cd-9c21-464cbe5c43f1	t	${role_manage-clients}	manage-clients	master	56449e2a-41ae-45cd-9c21-464cbe5c43f1	\N
794fa740-043c-4d69-9562-1f5bbf011478	56449e2a-41ae-45cd-9c21-464cbe5c43f1	t	${role_manage-events}	manage-events	master	56449e2a-41ae-45cd-9c21-464cbe5c43f1	\N
0a84c669-db58-4e0b-a576-0f5d311b41d7	56449e2a-41ae-45cd-9c21-464cbe5c43f1	t	${role_manage-identity-providers}	manage-identity-providers	master	56449e2a-41ae-45cd-9c21-464cbe5c43f1	\N
eeba9077-911f-488f-9e0b-af912c1e5208	56449e2a-41ae-45cd-9c21-464cbe5c43f1	t	${role_manage-authorization}	manage-authorization	master	56449e2a-41ae-45cd-9c21-464cbe5c43f1	\N
e4483143-e154-4e9b-b83a-9c5b43880333	56449e2a-41ae-45cd-9c21-464cbe5c43f1	t	${role_query-users}	query-users	master	56449e2a-41ae-45cd-9c21-464cbe5c43f1	\N
c557e233-a735-42aa-a9c0-2f7819c8ed67	56449e2a-41ae-45cd-9c21-464cbe5c43f1	t	${role_query-clients}	query-clients	master	56449e2a-41ae-45cd-9c21-464cbe5c43f1	\N
d5e16403-89c5-4a5b-a838-5d36968db6c6	56449e2a-41ae-45cd-9c21-464cbe5c43f1	t	${role_query-realms}	query-realms	master	56449e2a-41ae-45cd-9c21-464cbe5c43f1	\N
a119d61b-8890-4053-8544-5b5c11303a40	56449e2a-41ae-45cd-9c21-464cbe5c43f1	t	${role_query-groups}	query-groups	master	56449e2a-41ae-45cd-9c21-464cbe5c43f1	\N
5305ce79-6358-4391-99b7-9cd6a06429a4	CC	f	${role_uma_authorization}	uma_authorization	CC	\N	\N
008360b3-9666-404c-a2ad-788147654cac	CC	f	${role_offline-access}	offline_access	CC	\N	\N
05c89a52-239d-45ba-b644-491bc6a97b10	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	t	${role_view-clients}	view-clients	CC	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	\N
96fcc8f8-c9fc-4fb5-96ec-4207aacad947	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	t	${role_query-groups}	query-groups	CC	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	\N
8e70c551-ae07-46d2-84a4-a295447c2869	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	t	${role_create-client}	create-client	CC	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	\N
5db7a446-8b92-4d12-b928-42b387220c63	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	t	${role_query-users}	query-users	CC	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	\N
7863bc9a-df8c-4ee6-ad55-28ce5fd734ba	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	t	${role_view-authorization}	view-authorization	CC	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	\N
35153be4-77dd-4ce1-b779-f6218e2b3a89	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	t	${role_view-realm}	view-realm	CC	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	\N
b73c1b8a-4755-47f0-af12-8c917fffeda7	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	t	${role_view-identity-providers}	view-identity-providers	CC	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	\N
fa453334-d981-4997-9815-390e2564a8b5	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	t	${role_manage-authorization}	manage-authorization	CC	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	\N
d234085f-4360-4df2-881e-d28730a1d47a	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	t	${role_view-users}	view-users	CC	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	\N
c8081ddd-a50b-460c-ae4e-aa93b043594a	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	t	${role_query-realms}	query-realms	CC	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	\N
a7ab5d31-0388-46ca-9ac0-30002f493981	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	t	${role_manage-clients}	manage-clients	CC	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	\N
b4e94c7e-2bfa-436c-b967-1e0060018b60	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	t	${role_manage-realm}	manage-realm	CC	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	\N
ad7221e6-5a5e-48ec-9695-6d4299afdfc7	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	t	${role_manage-events}	manage-events	CC	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	\N
3213f038-f1e6-46a7-a719-2bd956751c0d	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	t	${role_manage-identity-providers}	manage-identity-providers	CC	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	\N
28f37dc9-4a17-489f-8a58-b998b5791583	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	t	${role_manage-users}	manage-users	CC	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	\N
eb7fc4c4-6f74-4539-a929-d6df8ece2ca6	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	t	${role_view-events}	view-events	CC	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	\N
44f9a8ab-add5-4a9d-985a-db30e70fa3cf	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	t	${role_impersonation}	impersonation	CC	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	\N
83c9992d-55a4-4588-8cfb-8349167a6d7e	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	t	${role_query-clients}	query-clients	CC	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	\N
8c7bebbb-5060-40b1-95d3-fd4219296dd9	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	t	${role_realm-admin}	realm-admin	CC	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	\N
0a1943d6-84ed-4f32-9ecd-72068b5f67ea	dcfd7631-d53e-4bce-b337-40ec363a561e	t	${role_read-token}	read-token	CC	dcfd7631-d53e-4bce-b337-40ec363a561e	\N
ace9a4e6-d3d9-4c51-8c24-2ec63a4d1f52	006df867-19d0-4bbc-9de7-f01ca96aaf7a	t	${role_manage-account}	manage-account	CC	006df867-19d0-4bbc-9de7-f01ca96aaf7a	\N
1587302c-2a32-4269-a44b-be9365f53141	006df867-19d0-4bbc-9de7-f01ca96aaf7a	t	${role_delete-account}	delete-account	CC	006df867-19d0-4bbc-9de7-f01ca96aaf7a	\N
e20dae00-71af-4cb7-866c-9be1bda08605	006df867-19d0-4bbc-9de7-f01ca96aaf7a	t	${role_view-applications}	view-applications	CC	006df867-19d0-4bbc-9de7-f01ca96aaf7a	\N
1e953e82-93ba-403e-be31-42a37faec734	006df867-19d0-4bbc-9de7-f01ca96aaf7a	t	${role_view-consent}	view-consent	CC	006df867-19d0-4bbc-9de7-f01ca96aaf7a	\N
8f504e9b-11d3-4744-b255-ce11f249e9e2	006df867-19d0-4bbc-9de7-f01ca96aaf7a	t	${role_manage-account-links}	manage-account-links	CC	006df867-19d0-4bbc-9de7-f01ca96aaf7a	\N
aa5e4901-3930-4788-8886-6b5af219084b	006df867-19d0-4bbc-9de7-f01ca96aaf7a	t	${role_manage-consent}	manage-consent	CC	006df867-19d0-4bbc-9de7-f01ca96aaf7a	\N
f2b7512e-6080-41be-ad38-46292cb9061e	006df867-19d0-4bbc-9de7-f01ca96aaf7a	t	${role_view-profile}	view-profile	CC	006df867-19d0-4bbc-9de7-f01ca96aaf7a	\N
46e8ee7c-369a-49d8-a8ed-890298d4a047	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	t	\N	uma_protection	CC	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	\N
d218ac73-b8b6-443b-9481-f45bf02a7592	56449e2a-41ae-45cd-9c21-464cbe5c43f1	t	${role_impersonation}	impersonation	master	56449e2a-41ae-45cd-9c21-464cbe5c43f1	\N
\.


--
-- TOC entry 4166 (class 0 OID 42894)
-- Dependencies: 257
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.migration_model (id, version, update_time) FROM stdin;
cggaq	14.0.0	1634204293
\.


--
-- TOC entry 4167 (class 0 OID 42898)
-- Dependencies: 258
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- TOC entry 4168 (class 0 OID 42905)
-- Dependencies: 259
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh) FROM stdin;
\.


--
-- TOC entry 4169 (class 0 OID 42911)
-- Dependencies: 260
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- TOC entry 4170 (class 0 OID 42916)
-- Dependencies: 261
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
3ed81ed9-4ff4-42a2-93a6-7e1d4f6d3ff8	audience resolve	openid-connect	oidc-audience-resolve-mapper	8433c1fd-5ede-4535-a056-2e4b8c0a289a	\N
6984ab69-8fa0-460a-a67f-8354ffe03928	locale	openid-connect	oidc-usermodel-attribute-mapper	9b7ac9ff-5213-44a3-988c-a6f181f31507	\N
4f974aff-e048-4f65-9631-debeaea5ecc8	role list	saml	saml-role-list-mapper	\N	1fbbf0e1-c81a-4757-90d1-a8b65a6eac26
b15cc8b5-efa3-4858-acd6-81c5bc1e6a3b	full name	openid-connect	oidc-full-name-mapper	\N	dc6899d1-5be4-40c7-8664-7baf2178f8be
82cf3018-4af5-4c6e-beb5-9018a51f9818	family name	openid-connect	oidc-usermodel-property-mapper	\N	dc6899d1-5be4-40c7-8664-7baf2178f8be
abd805b7-a1d2-4c07-b732-daa8de05c2c7	given name	openid-connect	oidc-usermodel-property-mapper	\N	dc6899d1-5be4-40c7-8664-7baf2178f8be
c780b15c-cbf0-4ca2-a713-dbda4b994189	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	dc6899d1-5be4-40c7-8664-7baf2178f8be
4d13e5c1-7cef-4f77-ae7a-ff9474cff821	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	dc6899d1-5be4-40c7-8664-7baf2178f8be
37f4bcdc-27db-4f4b-9350-40ff155fa38c	username	openid-connect	oidc-usermodel-property-mapper	\N	dc6899d1-5be4-40c7-8664-7baf2178f8be
a162444c-4939-4e51-9f18-65d55c43895a	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	dc6899d1-5be4-40c7-8664-7baf2178f8be
7c197fb3-a2bb-477b-955a-5043cdb5a33b	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	dc6899d1-5be4-40c7-8664-7baf2178f8be
2a64593e-2954-4c8e-8d36-240f55e78959	website	openid-connect	oidc-usermodel-attribute-mapper	\N	dc6899d1-5be4-40c7-8664-7baf2178f8be
3f3b4647-d933-433b-af2b-b185d2c21f75	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	dc6899d1-5be4-40c7-8664-7baf2178f8be
577b334b-c402-40a8-9389-9e30a0449e73	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	dc6899d1-5be4-40c7-8664-7baf2178f8be
c9ee21f1-1c8b-4f06-bdc3-20922f648c8a	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	dc6899d1-5be4-40c7-8664-7baf2178f8be
f921ac07-aff1-4460-9050-4563b6e20c76	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	dc6899d1-5be4-40c7-8664-7baf2178f8be
f2c92703-8cbd-4f3b-8c07-e5de18c4b5f7	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	dc6899d1-5be4-40c7-8664-7baf2178f8be
3854067e-8870-4c06-9e48-6ff7b09f2dc2	email	openid-connect	oidc-usermodel-property-mapper	\N	20831ba4-8f6e-41c9-8f1e-e625242a8e0c
43bb7c54-af3d-4eb8-ac4f-72a8f90e4407	email verified	openid-connect	oidc-usermodel-property-mapper	\N	20831ba4-8f6e-41c9-8f1e-e625242a8e0c
7a72bf05-7bfa-4c9d-9bc6-5cb1917b67f6	address	openid-connect	oidc-address-mapper	\N	73953e93-d388-40b3-85cc-d2ebc1f6fbb0
cd2ff7cd-7451-45cf-95a3-12f30f551bea	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	d7691612-6a6a-4ddd-a188-ddbfadfb8a9c
c69e5d70-ed00-48cc-981f-96b96d5ed83d	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	d7691612-6a6a-4ddd-a188-ddbfadfb8a9c
38535a9f-f3e6-425e-b5b8-92c4fe282dad	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	33e00a2e-fadf-4389-a762-0118a9c1badb
137e6677-69f0-4037-b84e-1c59c5c7f899	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	33e00a2e-fadf-4389-a762-0118a9c1badb
d986b59b-9a7f-4331-b2b9-d00377698510	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	33e00a2e-fadf-4389-a762-0118a9c1badb
ef1f851b-e1d4-45e4-befa-e83495f936e2	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	309eaf84-3a62-41cd-82b6-65ca26f3a731
f3bd9603-affc-4152-8861-d528d524425d	upn	openid-connect	oidc-usermodel-property-mapper	\N	9d2741a0-6c1f-41fd-b8ef-76e99a594225
cc6a779f-e4c8-4a77-94ed-432fd6c61fc7	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	9d2741a0-6c1f-41fd-b8ef-76e99a594225
b0acf7da-600a-4a47-9355-623f153b8327	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	72d38159-ce38-477d-b26a-695d1be288d8
a50fcab0-476e-48c8-ab40-79c64cfd88ca	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	72d38159-ce38-477d-b26a-695d1be288d8
08444c68-5485-4a61-a765-1bb86e3b6269	address	openid-connect	oidc-address-mapper	\N	4cf73263-9888-43d5-af5b-fc70ea4b99be
371d4dfb-e891-4435-869e-56b6ecc542f4	full name	openid-connect	oidc-full-name-mapper	\N	13ac6628-4572-4335-a50c-2761c21c3cc0
1a66fb91-d4eb-4827-8333-981cf0c5a1c8	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	13ac6628-4572-4335-a50c-2761c21c3cc0
040bc87b-2867-46c4-8b13-6a7747bc8760	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	13ac6628-4572-4335-a50c-2761c21c3cc0
2550810f-bbd9-4ac6-8acf-bc9a69b0c483	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	13ac6628-4572-4335-a50c-2761c21c3cc0
a234d74f-604f-47fa-8ab1-e972235702d6	family name	openid-connect	oidc-usermodel-property-mapper	\N	13ac6628-4572-4335-a50c-2761c21c3cc0
7309e370-dbe1-43ed-8957-314bb1da2f9b	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	13ac6628-4572-4335-a50c-2761c21c3cc0
56490ba2-417d-438f-aab6-1e842786ed06	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	13ac6628-4572-4335-a50c-2761c21c3cc0
ad67e014-4df2-4cc5-a579-a6c2ff57c695	website	openid-connect	oidc-usermodel-attribute-mapper	\N	13ac6628-4572-4335-a50c-2761c21c3cc0
106ee0a5-b51c-44cf-a9c1-bab516e0b02b	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	13ac6628-4572-4335-a50c-2761c21c3cc0
e4e4b815-68c1-4778-a229-339ed212955c	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	13ac6628-4572-4335-a50c-2761c21c3cc0
d81c7303-efc1-4117-9ca2-90d3b0d81c3d	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	13ac6628-4572-4335-a50c-2761c21c3cc0
45297296-4c3c-46d6-8d7d-cb2878c2e292	given name	openid-connect	oidc-usermodel-property-mapper	\N	13ac6628-4572-4335-a50c-2761c21c3cc0
33a47c5c-4b32-4ad1-a3ac-4eb75e3a25c7	username	openid-connect	oidc-usermodel-property-mapper	\N	13ac6628-4572-4335-a50c-2761c21c3cc0
f89b4b98-b285-4670-870f-69f8c1496433	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	13ac6628-4572-4335-a50c-2761c21c3cc0
57afcb06-5d17-47ed-b6a9-aab49fd75005	email	openid-connect	oidc-usermodel-property-mapper	\N	0fb0feeb-c8d3-4a65-889d-fd69ce493eab
c1611c95-8cbc-4425-9b4b-7c2d1d52d14d	email verified	openid-connect	oidc-usermodel-property-mapper	\N	0fb0feeb-c8d3-4a65-889d-fd69ce493eab
28af74ee-f99d-4305-b8ef-1b2c6f96dc0f	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	323bbbd8-2c6c-4080-a351-7f4cf8fd42b2
050f2ace-1fcc-42b3-a942-9a1ba5ed6d11	role list	saml	saml-role-list-mapper	\N	fc4ba834-d258-4deb-9b04-5dac5518559a
b57e9183-70bd-47b5-bbcc-f46d165054d0	upn	openid-connect	oidc-usermodel-property-mapper	\N	bcca4bf3-80df-4c1c-9394-36b7263928b8
2f7c9fd1-4fd0-4e33-b58c-c193a54a9478	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	bcca4bf3-80df-4c1c-9394-36b7263928b8
7d445685-8192-467b-ada1-1fae0c55d63a	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	708c7fd8-1731-4cf9-8ea2-5b3bb57d65d6
18c49914-a10f-406b-b497-7970ca5483d5	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	708c7fd8-1731-4cf9-8ea2-5b3bb57d65d6
a8f1f05f-e7ba-4cdd-898b-f345af3ebbf6	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	708c7fd8-1731-4cf9-8ea2-5b3bb57d65d6
38f5eed2-aa2d-4a2f-b7c7-e8269eeb7a91	audience resolve	openid-connect	oidc-audience-resolve-mapper	87ae7e2b-85a5-4f5c-a55b-4596d7dd3baa	\N
68e44953-9083-488c-be5e-b1c41bcf7a73	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	\N
3a1d6e13-865f-4851-90dd-ab9cbedff475	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	\N
287858ff-d6bb-4eb9-895e-f9e8fbc61f39	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	\N
7b81f46f-a8f9-46c9-9e61-4e4ba4e12e32	locale	openid-connect	oidc-usermodel-attribute-mapper	f0f69f18-4c7f-4850-a6f3-8bc4b0189408	\N
dc847e6e-e30b-4b55-bc5f-46d37f7eefca	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	\N
82f6c6a6-be10-4625-81c9-64c20e791bdf	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	\N
9bcbf965-812f-4773-8ddc-c33ebc7f1837	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	\N
\.


--
-- TOC entry 4171 (class 0 OID 42921)
-- Dependencies: 262
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
6984ab69-8fa0-460a-a67f-8354ffe03928	true	userinfo.token.claim
6984ab69-8fa0-460a-a67f-8354ffe03928	locale	user.attribute
6984ab69-8fa0-460a-a67f-8354ffe03928	true	id.token.claim
6984ab69-8fa0-460a-a67f-8354ffe03928	true	access.token.claim
6984ab69-8fa0-460a-a67f-8354ffe03928	locale	claim.name
6984ab69-8fa0-460a-a67f-8354ffe03928	String	jsonType.label
4f974aff-e048-4f65-9631-debeaea5ecc8	false	single
4f974aff-e048-4f65-9631-debeaea5ecc8	Basic	attribute.nameformat
4f974aff-e048-4f65-9631-debeaea5ecc8	Role	attribute.name
b15cc8b5-efa3-4858-acd6-81c5bc1e6a3b	true	userinfo.token.claim
b15cc8b5-efa3-4858-acd6-81c5bc1e6a3b	true	id.token.claim
b15cc8b5-efa3-4858-acd6-81c5bc1e6a3b	true	access.token.claim
82cf3018-4af5-4c6e-beb5-9018a51f9818	true	userinfo.token.claim
82cf3018-4af5-4c6e-beb5-9018a51f9818	lastName	user.attribute
82cf3018-4af5-4c6e-beb5-9018a51f9818	true	id.token.claim
82cf3018-4af5-4c6e-beb5-9018a51f9818	true	access.token.claim
82cf3018-4af5-4c6e-beb5-9018a51f9818	family_name	claim.name
82cf3018-4af5-4c6e-beb5-9018a51f9818	String	jsonType.label
abd805b7-a1d2-4c07-b732-daa8de05c2c7	true	userinfo.token.claim
abd805b7-a1d2-4c07-b732-daa8de05c2c7	firstName	user.attribute
abd805b7-a1d2-4c07-b732-daa8de05c2c7	true	id.token.claim
abd805b7-a1d2-4c07-b732-daa8de05c2c7	true	access.token.claim
abd805b7-a1d2-4c07-b732-daa8de05c2c7	given_name	claim.name
abd805b7-a1d2-4c07-b732-daa8de05c2c7	String	jsonType.label
c780b15c-cbf0-4ca2-a713-dbda4b994189	true	userinfo.token.claim
c780b15c-cbf0-4ca2-a713-dbda4b994189	middleName	user.attribute
c780b15c-cbf0-4ca2-a713-dbda4b994189	true	id.token.claim
c780b15c-cbf0-4ca2-a713-dbda4b994189	true	access.token.claim
c780b15c-cbf0-4ca2-a713-dbda4b994189	middle_name	claim.name
c780b15c-cbf0-4ca2-a713-dbda4b994189	String	jsonType.label
4d13e5c1-7cef-4f77-ae7a-ff9474cff821	true	userinfo.token.claim
4d13e5c1-7cef-4f77-ae7a-ff9474cff821	nickname	user.attribute
4d13e5c1-7cef-4f77-ae7a-ff9474cff821	true	id.token.claim
4d13e5c1-7cef-4f77-ae7a-ff9474cff821	true	access.token.claim
4d13e5c1-7cef-4f77-ae7a-ff9474cff821	nickname	claim.name
4d13e5c1-7cef-4f77-ae7a-ff9474cff821	String	jsonType.label
37f4bcdc-27db-4f4b-9350-40ff155fa38c	true	userinfo.token.claim
37f4bcdc-27db-4f4b-9350-40ff155fa38c	username	user.attribute
37f4bcdc-27db-4f4b-9350-40ff155fa38c	true	id.token.claim
37f4bcdc-27db-4f4b-9350-40ff155fa38c	true	access.token.claim
37f4bcdc-27db-4f4b-9350-40ff155fa38c	preferred_username	claim.name
37f4bcdc-27db-4f4b-9350-40ff155fa38c	String	jsonType.label
a162444c-4939-4e51-9f18-65d55c43895a	true	userinfo.token.claim
a162444c-4939-4e51-9f18-65d55c43895a	profile	user.attribute
a162444c-4939-4e51-9f18-65d55c43895a	true	id.token.claim
a162444c-4939-4e51-9f18-65d55c43895a	true	access.token.claim
a162444c-4939-4e51-9f18-65d55c43895a	profile	claim.name
a162444c-4939-4e51-9f18-65d55c43895a	String	jsonType.label
7c197fb3-a2bb-477b-955a-5043cdb5a33b	true	userinfo.token.claim
7c197fb3-a2bb-477b-955a-5043cdb5a33b	picture	user.attribute
7c197fb3-a2bb-477b-955a-5043cdb5a33b	true	id.token.claim
7c197fb3-a2bb-477b-955a-5043cdb5a33b	true	access.token.claim
7c197fb3-a2bb-477b-955a-5043cdb5a33b	picture	claim.name
7c197fb3-a2bb-477b-955a-5043cdb5a33b	String	jsonType.label
2a64593e-2954-4c8e-8d36-240f55e78959	true	userinfo.token.claim
2a64593e-2954-4c8e-8d36-240f55e78959	website	user.attribute
2a64593e-2954-4c8e-8d36-240f55e78959	true	id.token.claim
2a64593e-2954-4c8e-8d36-240f55e78959	true	access.token.claim
2a64593e-2954-4c8e-8d36-240f55e78959	website	claim.name
2a64593e-2954-4c8e-8d36-240f55e78959	String	jsonType.label
3f3b4647-d933-433b-af2b-b185d2c21f75	true	userinfo.token.claim
3f3b4647-d933-433b-af2b-b185d2c21f75	gender	user.attribute
3f3b4647-d933-433b-af2b-b185d2c21f75	true	id.token.claim
3f3b4647-d933-433b-af2b-b185d2c21f75	true	access.token.claim
3f3b4647-d933-433b-af2b-b185d2c21f75	gender	claim.name
3f3b4647-d933-433b-af2b-b185d2c21f75	String	jsonType.label
577b334b-c402-40a8-9389-9e30a0449e73	true	userinfo.token.claim
577b334b-c402-40a8-9389-9e30a0449e73	birthdate	user.attribute
577b334b-c402-40a8-9389-9e30a0449e73	true	id.token.claim
577b334b-c402-40a8-9389-9e30a0449e73	true	access.token.claim
577b334b-c402-40a8-9389-9e30a0449e73	birthdate	claim.name
577b334b-c402-40a8-9389-9e30a0449e73	String	jsonType.label
c9ee21f1-1c8b-4f06-bdc3-20922f648c8a	true	userinfo.token.claim
c9ee21f1-1c8b-4f06-bdc3-20922f648c8a	zoneinfo	user.attribute
c9ee21f1-1c8b-4f06-bdc3-20922f648c8a	true	id.token.claim
c9ee21f1-1c8b-4f06-bdc3-20922f648c8a	true	access.token.claim
c9ee21f1-1c8b-4f06-bdc3-20922f648c8a	zoneinfo	claim.name
c9ee21f1-1c8b-4f06-bdc3-20922f648c8a	String	jsonType.label
f921ac07-aff1-4460-9050-4563b6e20c76	true	userinfo.token.claim
f921ac07-aff1-4460-9050-4563b6e20c76	locale	user.attribute
f921ac07-aff1-4460-9050-4563b6e20c76	true	id.token.claim
f921ac07-aff1-4460-9050-4563b6e20c76	true	access.token.claim
f921ac07-aff1-4460-9050-4563b6e20c76	locale	claim.name
f921ac07-aff1-4460-9050-4563b6e20c76	String	jsonType.label
f2c92703-8cbd-4f3b-8c07-e5de18c4b5f7	true	userinfo.token.claim
f2c92703-8cbd-4f3b-8c07-e5de18c4b5f7	updatedAt	user.attribute
f2c92703-8cbd-4f3b-8c07-e5de18c4b5f7	true	id.token.claim
f2c92703-8cbd-4f3b-8c07-e5de18c4b5f7	true	access.token.claim
f2c92703-8cbd-4f3b-8c07-e5de18c4b5f7	updated_at	claim.name
f2c92703-8cbd-4f3b-8c07-e5de18c4b5f7	String	jsonType.label
3854067e-8870-4c06-9e48-6ff7b09f2dc2	true	userinfo.token.claim
3854067e-8870-4c06-9e48-6ff7b09f2dc2	email	user.attribute
3854067e-8870-4c06-9e48-6ff7b09f2dc2	true	id.token.claim
3854067e-8870-4c06-9e48-6ff7b09f2dc2	true	access.token.claim
3854067e-8870-4c06-9e48-6ff7b09f2dc2	email	claim.name
3854067e-8870-4c06-9e48-6ff7b09f2dc2	String	jsonType.label
43bb7c54-af3d-4eb8-ac4f-72a8f90e4407	true	userinfo.token.claim
43bb7c54-af3d-4eb8-ac4f-72a8f90e4407	emailVerified	user.attribute
43bb7c54-af3d-4eb8-ac4f-72a8f90e4407	true	id.token.claim
43bb7c54-af3d-4eb8-ac4f-72a8f90e4407	true	access.token.claim
43bb7c54-af3d-4eb8-ac4f-72a8f90e4407	email_verified	claim.name
43bb7c54-af3d-4eb8-ac4f-72a8f90e4407	boolean	jsonType.label
7a72bf05-7bfa-4c9d-9bc6-5cb1917b67f6	formatted	user.attribute.formatted
7a72bf05-7bfa-4c9d-9bc6-5cb1917b67f6	country	user.attribute.country
7a72bf05-7bfa-4c9d-9bc6-5cb1917b67f6	postal_code	user.attribute.postal_code
7a72bf05-7bfa-4c9d-9bc6-5cb1917b67f6	true	userinfo.token.claim
7a72bf05-7bfa-4c9d-9bc6-5cb1917b67f6	street	user.attribute.street
7a72bf05-7bfa-4c9d-9bc6-5cb1917b67f6	true	id.token.claim
7a72bf05-7bfa-4c9d-9bc6-5cb1917b67f6	region	user.attribute.region
7a72bf05-7bfa-4c9d-9bc6-5cb1917b67f6	true	access.token.claim
7a72bf05-7bfa-4c9d-9bc6-5cb1917b67f6	locality	user.attribute.locality
cd2ff7cd-7451-45cf-95a3-12f30f551bea	true	userinfo.token.claim
cd2ff7cd-7451-45cf-95a3-12f30f551bea	phoneNumber	user.attribute
cd2ff7cd-7451-45cf-95a3-12f30f551bea	true	id.token.claim
cd2ff7cd-7451-45cf-95a3-12f30f551bea	true	access.token.claim
cd2ff7cd-7451-45cf-95a3-12f30f551bea	phone_number	claim.name
cd2ff7cd-7451-45cf-95a3-12f30f551bea	String	jsonType.label
c69e5d70-ed00-48cc-981f-96b96d5ed83d	true	userinfo.token.claim
c69e5d70-ed00-48cc-981f-96b96d5ed83d	phoneNumberVerified	user.attribute
c69e5d70-ed00-48cc-981f-96b96d5ed83d	true	id.token.claim
c69e5d70-ed00-48cc-981f-96b96d5ed83d	true	access.token.claim
c69e5d70-ed00-48cc-981f-96b96d5ed83d	phone_number_verified	claim.name
c69e5d70-ed00-48cc-981f-96b96d5ed83d	boolean	jsonType.label
38535a9f-f3e6-425e-b5b8-92c4fe282dad	true	multivalued
38535a9f-f3e6-425e-b5b8-92c4fe282dad	foo	user.attribute
38535a9f-f3e6-425e-b5b8-92c4fe282dad	true	access.token.claim
38535a9f-f3e6-425e-b5b8-92c4fe282dad	realm_access.roles	claim.name
38535a9f-f3e6-425e-b5b8-92c4fe282dad	String	jsonType.label
137e6677-69f0-4037-b84e-1c59c5c7f899	true	multivalued
137e6677-69f0-4037-b84e-1c59c5c7f899	foo	user.attribute
137e6677-69f0-4037-b84e-1c59c5c7f899	true	access.token.claim
137e6677-69f0-4037-b84e-1c59c5c7f899	resource_access.${client_id}.roles	claim.name
137e6677-69f0-4037-b84e-1c59c5c7f899	String	jsonType.label
f3bd9603-affc-4152-8861-d528d524425d	true	userinfo.token.claim
f3bd9603-affc-4152-8861-d528d524425d	username	user.attribute
f3bd9603-affc-4152-8861-d528d524425d	true	id.token.claim
f3bd9603-affc-4152-8861-d528d524425d	true	access.token.claim
f3bd9603-affc-4152-8861-d528d524425d	upn	claim.name
f3bd9603-affc-4152-8861-d528d524425d	String	jsonType.label
cc6a779f-e4c8-4a77-94ed-432fd6c61fc7	true	multivalued
cc6a779f-e4c8-4a77-94ed-432fd6c61fc7	foo	user.attribute
cc6a779f-e4c8-4a77-94ed-432fd6c61fc7	true	id.token.claim
cc6a779f-e4c8-4a77-94ed-432fd6c61fc7	true	access.token.claim
cc6a779f-e4c8-4a77-94ed-432fd6c61fc7	groups	claim.name
cc6a779f-e4c8-4a77-94ed-432fd6c61fc7	String	jsonType.label
b0acf7da-600a-4a47-9355-623f153b8327	true	userinfo.token.claim
b0acf7da-600a-4a47-9355-623f153b8327	phoneNumber	user.attribute
b0acf7da-600a-4a47-9355-623f153b8327	true	id.token.claim
b0acf7da-600a-4a47-9355-623f153b8327	true	access.token.claim
b0acf7da-600a-4a47-9355-623f153b8327	phone_number	claim.name
b0acf7da-600a-4a47-9355-623f153b8327	String	jsonType.label
a50fcab0-476e-48c8-ab40-79c64cfd88ca	true	userinfo.token.claim
a50fcab0-476e-48c8-ab40-79c64cfd88ca	phoneNumberVerified	user.attribute
a50fcab0-476e-48c8-ab40-79c64cfd88ca	true	id.token.claim
a50fcab0-476e-48c8-ab40-79c64cfd88ca	true	access.token.claim
a50fcab0-476e-48c8-ab40-79c64cfd88ca	phone_number_verified	claim.name
a50fcab0-476e-48c8-ab40-79c64cfd88ca	boolean	jsonType.label
08444c68-5485-4a61-a765-1bb86e3b6269	formatted	user.attribute.formatted
08444c68-5485-4a61-a765-1bb86e3b6269	country	user.attribute.country
08444c68-5485-4a61-a765-1bb86e3b6269	postal_code	user.attribute.postal_code
08444c68-5485-4a61-a765-1bb86e3b6269	true	userinfo.token.claim
08444c68-5485-4a61-a765-1bb86e3b6269	street	user.attribute.street
08444c68-5485-4a61-a765-1bb86e3b6269	true	id.token.claim
08444c68-5485-4a61-a765-1bb86e3b6269	region	user.attribute.region
08444c68-5485-4a61-a765-1bb86e3b6269	true	access.token.claim
08444c68-5485-4a61-a765-1bb86e3b6269	locality	user.attribute.locality
371d4dfb-e891-4435-869e-56b6ecc542f4	true	id.token.claim
371d4dfb-e891-4435-869e-56b6ecc542f4	true	access.token.claim
371d4dfb-e891-4435-869e-56b6ecc542f4	true	userinfo.token.claim
1a66fb91-d4eb-4827-8333-981cf0c5a1c8	true	userinfo.token.claim
1a66fb91-d4eb-4827-8333-981cf0c5a1c8	birthdate	user.attribute
1a66fb91-d4eb-4827-8333-981cf0c5a1c8	true	id.token.claim
1a66fb91-d4eb-4827-8333-981cf0c5a1c8	true	access.token.claim
1a66fb91-d4eb-4827-8333-981cf0c5a1c8	birthdate	claim.name
1a66fb91-d4eb-4827-8333-981cf0c5a1c8	String	jsonType.label
040bc87b-2867-46c4-8b13-6a7747bc8760	true	userinfo.token.claim
040bc87b-2867-46c4-8b13-6a7747bc8760	updatedAt	user.attribute
040bc87b-2867-46c4-8b13-6a7747bc8760	true	id.token.claim
040bc87b-2867-46c4-8b13-6a7747bc8760	true	access.token.claim
040bc87b-2867-46c4-8b13-6a7747bc8760	updated_at	claim.name
040bc87b-2867-46c4-8b13-6a7747bc8760	String	jsonType.label
2550810f-bbd9-4ac6-8acf-bc9a69b0c483	true	userinfo.token.claim
2550810f-bbd9-4ac6-8acf-bc9a69b0c483	picture	user.attribute
2550810f-bbd9-4ac6-8acf-bc9a69b0c483	true	id.token.claim
2550810f-bbd9-4ac6-8acf-bc9a69b0c483	true	access.token.claim
2550810f-bbd9-4ac6-8acf-bc9a69b0c483	picture	claim.name
2550810f-bbd9-4ac6-8acf-bc9a69b0c483	String	jsonType.label
a234d74f-604f-47fa-8ab1-e972235702d6	true	userinfo.token.claim
a234d74f-604f-47fa-8ab1-e972235702d6	lastName	user.attribute
a234d74f-604f-47fa-8ab1-e972235702d6	true	id.token.claim
a234d74f-604f-47fa-8ab1-e972235702d6	true	access.token.claim
a234d74f-604f-47fa-8ab1-e972235702d6	family_name	claim.name
a234d74f-604f-47fa-8ab1-e972235702d6	String	jsonType.label
7309e370-dbe1-43ed-8957-314bb1da2f9b	true	userinfo.token.claim
7309e370-dbe1-43ed-8957-314bb1da2f9b	locale	user.attribute
7309e370-dbe1-43ed-8957-314bb1da2f9b	true	id.token.claim
7309e370-dbe1-43ed-8957-314bb1da2f9b	true	access.token.claim
7309e370-dbe1-43ed-8957-314bb1da2f9b	locale	claim.name
7309e370-dbe1-43ed-8957-314bb1da2f9b	String	jsonType.label
56490ba2-417d-438f-aab6-1e842786ed06	true	userinfo.token.claim
56490ba2-417d-438f-aab6-1e842786ed06	nickname	user.attribute
56490ba2-417d-438f-aab6-1e842786ed06	true	id.token.claim
56490ba2-417d-438f-aab6-1e842786ed06	true	access.token.claim
56490ba2-417d-438f-aab6-1e842786ed06	nickname	claim.name
56490ba2-417d-438f-aab6-1e842786ed06	String	jsonType.label
ad67e014-4df2-4cc5-a579-a6c2ff57c695	true	userinfo.token.claim
ad67e014-4df2-4cc5-a579-a6c2ff57c695	website	user.attribute
ad67e014-4df2-4cc5-a579-a6c2ff57c695	true	id.token.claim
ad67e014-4df2-4cc5-a579-a6c2ff57c695	true	access.token.claim
ad67e014-4df2-4cc5-a579-a6c2ff57c695	website	claim.name
ad67e014-4df2-4cc5-a579-a6c2ff57c695	String	jsonType.label
106ee0a5-b51c-44cf-a9c1-bab516e0b02b	true	userinfo.token.claim
106ee0a5-b51c-44cf-a9c1-bab516e0b02b	zoneinfo	user.attribute
106ee0a5-b51c-44cf-a9c1-bab516e0b02b	true	id.token.claim
106ee0a5-b51c-44cf-a9c1-bab516e0b02b	true	access.token.claim
106ee0a5-b51c-44cf-a9c1-bab516e0b02b	zoneinfo	claim.name
106ee0a5-b51c-44cf-a9c1-bab516e0b02b	String	jsonType.label
e4e4b815-68c1-4778-a229-339ed212955c	true	userinfo.token.claim
e4e4b815-68c1-4778-a229-339ed212955c	gender	user.attribute
e4e4b815-68c1-4778-a229-339ed212955c	true	id.token.claim
e4e4b815-68c1-4778-a229-339ed212955c	true	access.token.claim
e4e4b815-68c1-4778-a229-339ed212955c	gender	claim.name
e4e4b815-68c1-4778-a229-339ed212955c	String	jsonType.label
d81c7303-efc1-4117-9ca2-90d3b0d81c3d	true	userinfo.token.claim
d81c7303-efc1-4117-9ca2-90d3b0d81c3d	profile	user.attribute
d81c7303-efc1-4117-9ca2-90d3b0d81c3d	true	id.token.claim
d81c7303-efc1-4117-9ca2-90d3b0d81c3d	true	access.token.claim
d81c7303-efc1-4117-9ca2-90d3b0d81c3d	profile	claim.name
d81c7303-efc1-4117-9ca2-90d3b0d81c3d	String	jsonType.label
45297296-4c3c-46d6-8d7d-cb2878c2e292	true	userinfo.token.claim
45297296-4c3c-46d6-8d7d-cb2878c2e292	firstName	user.attribute
45297296-4c3c-46d6-8d7d-cb2878c2e292	true	id.token.claim
45297296-4c3c-46d6-8d7d-cb2878c2e292	true	access.token.claim
45297296-4c3c-46d6-8d7d-cb2878c2e292	given_name	claim.name
45297296-4c3c-46d6-8d7d-cb2878c2e292	String	jsonType.label
33a47c5c-4b32-4ad1-a3ac-4eb75e3a25c7	true	userinfo.token.claim
33a47c5c-4b32-4ad1-a3ac-4eb75e3a25c7	username	user.attribute
33a47c5c-4b32-4ad1-a3ac-4eb75e3a25c7	true	id.token.claim
33a47c5c-4b32-4ad1-a3ac-4eb75e3a25c7	true	access.token.claim
33a47c5c-4b32-4ad1-a3ac-4eb75e3a25c7	preferred_username	claim.name
33a47c5c-4b32-4ad1-a3ac-4eb75e3a25c7	String	jsonType.label
f89b4b98-b285-4670-870f-69f8c1496433	true	userinfo.token.claim
f89b4b98-b285-4670-870f-69f8c1496433	middleName	user.attribute
f89b4b98-b285-4670-870f-69f8c1496433	true	id.token.claim
f89b4b98-b285-4670-870f-69f8c1496433	true	access.token.claim
f89b4b98-b285-4670-870f-69f8c1496433	middle_name	claim.name
f89b4b98-b285-4670-870f-69f8c1496433	String	jsonType.label
57afcb06-5d17-47ed-b6a9-aab49fd75005	true	userinfo.token.claim
57afcb06-5d17-47ed-b6a9-aab49fd75005	email	user.attribute
57afcb06-5d17-47ed-b6a9-aab49fd75005	true	id.token.claim
57afcb06-5d17-47ed-b6a9-aab49fd75005	true	access.token.claim
57afcb06-5d17-47ed-b6a9-aab49fd75005	email	claim.name
57afcb06-5d17-47ed-b6a9-aab49fd75005	String	jsonType.label
c1611c95-8cbc-4425-9b4b-7c2d1d52d14d	true	userinfo.token.claim
c1611c95-8cbc-4425-9b4b-7c2d1d52d14d	emailVerified	user.attribute
c1611c95-8cbc-4425-9b4b-7c2d1d52d14d	true	id.token.claim
c1611c95-8cbc-4425-9b4b-7c2d1d52d14d	true	access.token.claim
c1611c95-8cbc-4425-9b4b-7c2d1d52d14d	email_verified	claim.name
c1611c95-8cbc-4425-9b4b-7c2d1d52d14d	boolean	jsonType.label
050f2ace-1fcc-42b3-a942-9a1ba5ed6d11	false	single
050f2ace-1fcc-42b3-a942-9a1ba5ed6d11	Basic	attribute.nameformat
050f2ace-1fcc-42b3-a942-9a1ba5ed6d11	Role	attribute.name
b57e9183-70bd-47b5-bbcc-f46d165054d0	true	userinfo.token.claim
b57e9183-70bd-47b5-bbcc-f46d165054d0	username	user.attribute
b57e9183-70bd-47b5-bbcc-f46d165054d0	true	id.token.claim
b57e9183-70bd-47b5-bbcc-f46d165054d0	true	access.token.claim
b57e9183-70bd-47b5-bbcc-f46d165054d0	upn	claim.name
b57e9183-70bd-47b5-bbcc-f46d165054d0	String	jsonType.label
2f7c9fd1-4fd0-4e33-b58c-c193a54a9478	true	multivalued
2f7c9fd1-4fd0-4e33-b58c-c193a54a9478	true	userinfo.token.claim
2f7c9fd1-4fd0-4e33-b58c-c193a54a9478	foo	user.attribute
2f7c9fd1-4fd0-4e33-b58c-c193a54a9478	true	id.token.claim
2f7c9fd1-4fd0-4e33-b58c-c193a54a9478	true	access.token.claim
2f7c9fd1-4fd0-4e33-b58c-c193a54a9478	groups	claim.name
2f7c9fd1-4fd0-4e33-b58c-c193a54a9478	String	jsonType.label
7d445685-8192-467b-ada1-1fae0c55d63a	foo	user.attribute
7d445685-8192-467b-ada1-1fae0c55d63a	true	access.token.claim
7d445685-8192-467b-ada1-1fae0c55d63a	realm_access.roles	claim.name
7d445685-8192-467b-ada1-1fae0c55d63a	String	jsonType.label
7d445685-8192-467b-ada1-1fae0c55d63a	true	multivalued
a8f1f05f-e7ba-4cdd-898b-f345af3ebbf6	foo	user.attribute
a8f1f05f-e7ba-4cdd-898b-f345af3ebbf6	true	access.token.claim
a8f1f05f-e7ba-4cdd-898b-f345af3ebbf6	resource_access.${client_id}.roles	claim.name
a8f1f05f-e7ba-4cdd-898b-f345af3ebbf6	String	jsonType.label
a8f1f05f-e7ba-4cdd-898b-f345af3ebbf6	true	multivalued
68e44953-9083-488c-be5e-b1c41bcf7a73	clientHost	user.session.note
68e44953-9083-488c-be5e-b1c41bcf7a73	true	id.token.claim
68e44953-9083-488c-be5e-b1c41bcf7a73	true	access.token.claim
68e44953-9083-488c-be5e-b1c41bcf7a73	clientHost	claim.name
68e44953-9083-488c-be5e-b1c41bcf7a73	String	jsonType.label
68e44953-9083-488c-be5e-b1c41bcf7a73	true	userinfo.token.claim
3a1d6e13-865f-4851-90dd-ab9cbedff475	clientId	user.session.note
3a1d6e13-865f-4851-90dd-ab9cbedff475	true	id.token.claim
3a1d6e13-865f-4851-90dd-ab9cbedff475	true	access.token.claim
3a1d6e13-865f-4851-90dd-ab9cbedff475	clientId	claim.name
3a1d6e13-865f-4851-90dd-ab9cbedff475	String	jsonType.label
287858ff-d6bb-4eb9-895e-f9e8fbc61f39	clientAddress	user.session.note
287858ff-d6bb-4eb9-895e-f9e8fbc61f39	true	id.token.claim
287858ff-d6bb-4eb9-895e-f9e8fbc61f39	true	access.token.claim
287858ff-d6bb-4eb9-895e-f9e8fbc61f39	clientAddress	claim.name
287858ff-d6bb-4eb9-895e-f9e8fbc61f39	String	jsonType.label
3a1d6e13-865f-4851-90dd-ab9cbedff475	true	userinfo.token.claim
287858ff-d6bb-4eb9-895e-f9e8fbc61f39	true	userinfo.token.claim
7b81f46f-a8f9-46c9-9e61-4e4ba4e12e32	true	userinfo.token.claim
7b81f46f-a8f9-46c9-9e61-4e4ba4e12e32	locale	user.attribute
7b81f46f-a8f9-46c9-9e61-4e4ba4e12e32	true	id.token.claim
7b81f46f-a8f9-46c9-9e61-4e4ba4e12e32	true	access.token.claim
7b81f46f-a8f9-46c9-9e61-4e4ba4e12e32	locale	claim.name
7b81f46f-a8f9-46c9-9e61-4e4ba4e12e32	String	jsonType.label
dc847e6e-e30b-4b55-bc5f-46d37f7eefca	clientId	user.session.note
dc847e6e-e30b-4b55-bc5f-46d37f7eefca	true	id.token.claim
dc847e6e-e30b-4b55-bc5f-46d37f7eefca	true	access.token.claim
dc847e6e-e30b-4b55-bc5f-46d37f7eefca	clientId	claim.name
dc847e6e-e30b-4b55-bc5f-46d37f7eefca	String	jsonType.label
82f6c6a6-be10-4625-81c9-64c20e791bdf	clientHost	user.session.note
82f6c6a6-be10-4625-81c9-64c20e791bdf	true	id.token.claim
82f6c6a6-be10-4625-81c9-64c20e791bdf	true	access.token.claim
82f6c6a6-be10-4625-81c9-64c20e791bdf	clientHost	claim.name
82f6c6a6-be10-4625-81c9-64c20e791bdf	String	jsonType.label
9bcbf965-812f-4773-8ddc-c33ebc7f1837	clientAddress	user.session.note
9bcbf965-812f-4773-8ddc-c33ebc7f1837	true	id.token.claim
9bcbf965-812f-4773-8ddc-c33ebc7f1837	true	access.token.claim
9bcbf965-812f-4773-8ddc-c33ebc7f1837	clientAddress	claim.name
9bcbf965-812f-4773-8ddc-c33ebc7f1837	String	jsonType.label
\.


--
-- TOC entry 4172 (class 0 OID 42926)
-- Dependencies: 263
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
master	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	afddb56d-0c09-4bb5-ba70-3d594f19d404	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	b26d517f-fe54-4ef2-9f85-e802b27b5074	23d319c4-c287-407b-a86b-e3cc4c11ef4e	52418229-2554-4b7d-8b4e-799635d9ed7b	b8105554-1902-4f9b-b81f-24b9afa98258	e9567cb7-01f7-4a2c-929a-3f33908f2254	2592000	f	900	t	f	079b613e-85ee-4499-ba03-937467d0aa0e	0	f	0	0	4a924ab3-e9d2-45af-9730-1723081a34d5
CC	60	300	300	\N	\N	\N	t	f	0	\N	CC	0	\N	t	f	f	f	EXTERNAL	1800	36000	f	f	56449e2a-41ae-45cd-9c21-464cbe5c43f1	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	6e85640d-e6c3-4b48-a8b9-12528e369bbd	1f7c329f-80fa-47f9-bf22-b0fb3fd3333b	1fdd1aef-9038-4dc3-ac05-bb746a360392	d52d288b-a24c-426c-9f10-5046c43f4e7f	8a3d4c9a-f3c6-49c1-a932-625a993fa21e	2592000	f	900	t	f	a03fdfa5-3a9e-463e-a442-eaa822da1ee5	0	f	0	0	64c8f33d-3a88-47d5-ae85-e7709b3c92bf
\.


--
-- TOC entry 4173 (class 0 OID 42959)
-- Dependencies: 264
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	master	
_browser_header.xContentTypeOptions	master	nosniff
_browser_header.xRobotsTag	master	none
_browser_header.xFrameOptions	master	SAMEORIGIN
_browser_header.contentSecurityPolicy	master	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	master	1; mode=block
_browser_header.strictTransportSecurity	master	max-age=31536000; includeSubDomains
bruteForceProtected	master	false
permanentLockout	master	false
maxFailureWaitSeconds	master	900
minimumQuickLoginWaitSeconds	master	60
waitIncrementSeconds	master	60
quickLoginCheckMilliSeconds	master	1000
maxDeltaTimeSeconds	master	43200
failureFactor	master	30
displayName	master	Keycloak
displayNameHtml	master	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	master	RS256
offlineSessionMaxLifespanEnabled	master	false
offlineSessionMaxLifespan	master	5184000
_browser_header.contentSecurityPolicyReportOnly	CC	
_browser_header.xContentTypeOptions	CC	nosniff
_browser_header.xRobotsTag	CC	none
_browser_header.xFrameOptions	CC	SAMEORIGIN
_browser_header.contentSecurityPolicy	CC	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	CC	1; mode=block
_browser_header.strictTransportSecurity	CC	max-age=31536000; includeSubDomains
bruteForceProtected	CC	false
permanentLockout	CC	false
maxFailureWaitSeconds	CC	900
minimumQuickLoginWaitSeconds	CC	60
waitIncrementSeconds	CC	60
quickLoginCheckMilliSeconds	CC	1000
maxDeltaTimeSeconds	CC	43200
failureFactor	CC	30
defaultSignatureAlgorithm	CC	RS256
offlineSessionMaxLifespanEnabled	CC	false
offlineSessionMaxLifespan	CC	5184000
clientSessionIdleTimeout	CC	0
clientSessionMaxLifespan	CC	0
clientOfflineSessionIdleTimeout	CC	0
clientOfflineSessionMaxLifespan	CC	0
actionTokenGeneratedByAdminLifespan	CC	43200
actionTokenGeneratedByUserLifespan	CC	300
oauth2DeviceCodeLifespan	CC	600
oauth2DevicePollingInterval	CC	5
webAuthnPolicyRpEntityName	CC	keycloak
webAuthnPolicySignatureAlgorithms	CC	ES256
webAuthnPolicyRpId	CC	
webAuthnPolicyAttestationConveyancePreference	CC	not specified
webAuthnPolicyAuthenticatorAttachment	CC	not specified
webAuthnPolicyRequireResidentKey	CC	not specified
webAuthnPolicyUserVerificationRequirement	CC	not specified
webAuthnPolicyCreateTimeout	CC	0
webAuthnPolicyAvoidSameAuthenticatorRegister	CC	false
webAuthnPolicyRpEntityNamePasswordless	CC	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	CC	ES256
webAuthnPolicyRpIdPasswordless	CC	
webAuthnPolicyAttestationConveyancePreferencePasswordless	CC	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	CC	not specified
webAuthnPolicyRequireResidentKeyPasswordless	CC	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	CC	not specified
webAuthnPolicyCreateTimeoutPasswordless	CC	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	CC	false
cibaBackchannelTokenDeliveryMode	CC	poll
cibaExpiresIn	CC	120
cibaInterval	CC	5
cibaAuthRequestedUserHint	CC	login_hint
client-policies.profiles	CC	{"profiles":[]}
client-policies.policies	CC	{"policies":[]}
\.


--
-- TOC entry 4174 (class 0 OID 42964)
-- Dependencies: 265
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
CC	1b5c0d65-8666-4805-b046-d2adbac999d3
\.


--
-- TOC entry 4175 (class 0 OID 42967)
-- Dependencies: 266
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- TOC entry 4176 (class 0 OID 42970)
-- Dependencies: 267
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
master	jboss-logging
CC	jboss-logging
\.


--
-- TOC entry 4177 (class 0 OID 42973)
-- Dependencies: 268
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- TOC entry 4178 (class 0 OID 42978)
-- Dependencies: 269
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	master
password	password	t	t	CC
\.


--
-- TOC entry 4179 (class 0 OID 42985)
-- Dependencies: 270
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
CC	false	starttls
CC	false	auth
CC	-	host
CC	a@a.c	from
CC		fromDisplayName
CC	false	ssl
\.


--
-- TOC entry 4180 (class 0 OID 42990)
-- Dependencies: 271
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- TOC entry 4181 (class 0 OID 42993)
-- Dependencies: 272
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.redirect_uris (client_id, value) FROM stdin;
df754331-dc4c-4886-aa39-4a7ac747b383	/realms/master/account/*
8433c1fd-5ede-4535-a056-2e4b8c0a289a	/realms/master/account/*
9b7ac9ff-5213-44a3-988c-a6f181f31507	/admin/master/console/*
006df867-19d0-4bbc-9de7-f01ca96aaf7a	/realms/CC/account/*
87ae7e2b-85a5-4f5c-a55b-4596d7dd3baa	/realms/CC/account/*
0ac48ba0-1e20-4236-8749-bed43d1a2737	*
f0f69f18-4c7f-4850-a6f3-8bc4b0189408	/admin/CC/console/*
\.


--
-- TOC entry 4182 (class 0 OID 42996)
-- Dependencies: 273
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- TOC entry 4183 (class 0 OID 43001)
-- Dependencies: 274
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
2ac3e35b-0a4a-424e-abd7-51dd5d49107f	VERIFY_EMAIL	Verify Email	master	t	f	VERIFY_EMAIL	50
4dbcc383-0317-4009-9327-4311a832949a	UPDATE_PROFILE	Update Profile	master	t	f	UPDATE_PROFILE	40
4bee35e2-cf17-4b38-b47b-9ea39a41dcd8	CONFIGURE_TOTP	Configure OTP	master	t	f	CONFIGURE_TOTP	10
821a958f-76bb-416d-a09f-9ea2a37e8821	UPDATE_PASSWORD	Update Password	master	t	f	UPDATE_PASSWORD	30
e00aaeaa-2ca8-4f12-90e7-25e759d57181	terms_and_conditions	Terms and Conditions	master	f	f	terms_and_conditions	20
e93affe6-e25c-471b-961e-33aa6d5df184	update_user_locale	Update User Locale	master	t	f	update_user_locale	1000
64e03cc1-5586-4832-be85-5ea5ad2d187b	delete_account	Delete Account	master	f	f	delete_account	60
53a5de68-f4d5-49ce-b87c-e08019efb441	CONFIGURE_TOTP	Configure OTP	CC	t	f	CONFIGURE_TOTP	10
7b382585-454f-475e-b4f8-2c45a9d0d253	terms_and_conditions	Terms and Conditions	CC	f	f	terms_and_conditions	20
9e6c2152-d596-4152-8575-2b64c5df6709	UPDATE_PASSWORD	Update Password	CC	t	f	UPDATE_PASSWORD	30
62ed3aed-1351-4fd8-9821-48e78f99a4f1	UPDATE_PROFILE	Update Profile	CC	t	f	UPDATE_PROFILE	40
7e9bec63-5b2a-4aba-bcea-416c5f0e0ce8	VERIFY_EMAIL	Verify Email	CC	t	f	VERIFY_EMAIL	50
b9b908b9-933d-4f88-9a45-4f50dd053b58	delete_account	Delete Account	CC	f	f	delete_account	60
b938e9e2-361e-4926-bc22-c14553136fcf	update_user_locale	Update User Locale	CC	t	f	update_user_locale	1000
\.


--
-- TOC entry 4184 (class 0 OID 43008)
-- Dependencies: 275
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- TOC entry 4185 (class 0 OID 43014)
-- Dependencies: 276
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- TOC entry 4186 (class 0 OID 43017)
-- Dependencies: 277
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- TOC entry 4187 (class 0 OID 43020)
-- Dependencies: 278
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
57d0ab0d-d25b-4b1d-91ee-1ed79754e651	f	0	1
\.


--
-- TOC entry 4188 (class 0 OID 43025)
-- Dependencies: 279
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- TOC entry 4189 (class 0 OID 43030)
-- Dependencies: 280
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- TOC entry 4190 (class 0 OID 43035)
-- Dependencies: 281
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- TOC entry 4191 (class 0 OID 43041)
-- Dependencies: 282
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
005eabd8-d8c2-4f3a-9a18-c14e946734a0	manage	\N	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	\N
28bdefe4-69f4-4d6e-95d9-157117efcb82	view	\N	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	\N
8dfa8b75-3289-4c3c-832b-73a51ba74e8c	map-roles	\N	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	\N
4e48f317-beb5-4ea2-b4b5-7b70166555b5	map-roles-client-scope	\N	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	\N
986425ac-0dc4-429d-a64b-ced753f8d20f	map-roles-composite	\N	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	\N
5e2969d3-f0c6-4074-bd43-74afedc31f08	configure	\N	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	\N
f8ba30f9-cebd-419a-9508-7c220a72bfdd	token-exchange	\N	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	\N
63e20785-cd9c-455d-90b9-5eb494bbd713	map-role	\N	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	\N
85ad1ebb-8afa-4734-b5bf-bac057d57f00	map-role-client-scope	\N	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	\N
7f795538-c0c7-459a-bf06-91c2d3b722c1	map-role-composite	\N	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	\N
\.


--
-- TOC entry 4192 (class 0 OID 43046)
-- Dependencies: 283
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_uris (resource_id, value) FROM stdin;
\.


--
-- TOC entry 4193 (class 0 OID 43049)
-- Dependencies: 284
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- TOC entry 4194 (class 0 OID 43054)
-- Dependencies: 285
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
8433c1fd-5ede-4535-a056-2e4b8c0a289a	f236e675-8505-423f-9cdd-b3f063b15572
87ae7e2b-85a5-4f5c-a55b-4596d7dd3baa	ace9a4e6-d3d9-4c51-8c24-2ec63a4d1f52
\.


--
-- TOC entry 4195 (class 0 OID 43057)
-- Dependencies: 286
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- TOC entry 4196 (class 0 OID 43060)
-- Dependencies: 287
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_attribute (name, value, user_id, id) FROM stdin;
\.


--
-- TOC entry 4197 (class 0 OID 43066)
-- Dependencies: 288
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- TOC entry 4198 (class 0 OID 43071)
-- Dependencies: 289
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- TOC entry 4199 (class 0 OID 43074)
-- Dependencies: 290
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
97f3b26f-a6ee-44c9-b682-b86d0be2667e	\N	e73b3154-0566-4241-bbcc-f530331f1804	f	t	\N	\N	\N	master	admin	1634204294334	\N	0
f3a7e2a1-540d-437d-b211-f33835f8017b	\N	ae8a41fa-4a42-43ee-8862-d950de8004e6	f	t	\N	\N	\N	CC	service-account-admin-cc	1638445063996	99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	0
12c2c058-9637-48fb-9542-8c98d89e9771	\N	74e06b7d-24dd-42c5-b41a-c75ad49dfe9b	f	t	\N	\N	\N	CC	service-account-realm-management	1647351020633	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	0
\.


--
-- TOC entry 4200 (class 0 OID 43082)
-- Dependencies: 291
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- TOC entry 4201 (class 0 OID 43087)
-- Dependencies: 292
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- TOC entry 4202 (class 0 OID 43092)
-- Dependencies: 293
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- TOC entry 4203 (class 0 OID 43097)
-- Dependencies: 294
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- TOC entry 4204 (class 0 OID 43102)
-- Dependencies: 295
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_group_membership (group_id, user_id) FROM stdin;
1b5c0d65-8666-4805-b046-d2adbac999d3	f3a7e2a1-540d-437d-b211-f33835f8017b
1b5c0d65-8666-4805-b046-d2adbac999d3	12c2c058-9637-48fb-9542-8c98d89e9771
\.


--
-- TOC entry 4205 (class 0 OID 43105)
-- Dependencies: 296
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- TOC entry 4206 (class 0 OID 43109)
-- Dependencies: 297
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
4a924ab3-e9d2-45af-9730-1723081a34d5	97f3b26f-a6ee-44c9-b682-b86d0be2667e
017a5b0c-2639-4149-9f37-9452dc8ff121	97f3b26f-a6ee-44c9-b682-b86d0be2667e
64c8f33d-3a88-47d5-ae85-e7709b3c92bf	f3a7e2a1-540d-437d-b211-f33835f8017b
96fcc8f8-c9fc-4fb5-96ec-4207aacad947	f3a7e2a1-540d-437d-b211-f33835f8017b
8e70c551-ae07-46d2-84a4-a295447c2869	f3a7e2a1-540d-437d-b211-f33835f8017b
5db7a446-8b92-4d12-b928-42b387220c63	f3a7e2a1-540d-437d-b211-f33835f8017b
fa453334-d981-4997-9815-390e2564a8b5	f3a7e2a1-540d-437d-b211-f33835f8017b
c8081ddd-a50b-460c-ae4e-aa93b043594a	f3a7e2a1-540d-437d-b211-f33835f8017b
a7ab5d31-0388-46ca-9ac0-30002f493981	f3a7e2a1-540d-437d-b211-f33835f8017b
b4e94c7e-2bfa-436c-b967-1e0060018b60	f3a7e2a1-540d-437d-b211-f33835f8017b
ad7221e6-5a5e-48ec-9695-6d4299afdfc7	f3a7e2a1-540d-437d-b211-f33835f8017b
3213f038-f1e6-46a7-a719-2bd956751c0d	f3a7e2a1-540d-437d-b211-f33835f8017b
28f37dc9-4a17-489f-8a58-b998b5791583	f3a7e2a1-540d-437d-b211-f33835f8017b
44f9a8ab-add5-4a9d-985a-db30e70fa3cf	f3a7e2a1-540d-437d-b211-f33835f8017b
83c9992d-55a4-4588-8cfb-8349167a6d7e	f3a7e2a1-540d-437d-b211-f33835f8017b
8c7bebbb-5060-40b1-95d3-fd4219296dd9	f3a7e2a1-540d-437d-b211-f33835f8017b
64c8f33d-3a88-47d5-ae85-e7709b3c92bf	12c2c058-9637-48fb-9542-8c98d89e9771
46e8ee7c-369a-49d8-a8ed-890298d4a047	12c2c058-9637-48fb-9542-8c98d89e9771
\.


--
-- TOC entry 4207 (class 0 OID 43112)
-- Dependencies: 298
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- TOC entry 4208 (class 0 OID 43118)
-- Dependencies: 299
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- TOC entry 4209 (class 0 OID 43123)
-- Dependencies: 300
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- TOC entry 4210 (class 0 OID 43128)
-- Dependencies: 301
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.web_origins (client_id, value) FROM stdin;
9b7ac9ff-5213-44a3-988c-a6f181f31507	+
0ac48ba0-1e20-4236-8749-bed43d1a2737	*
f0f69f18-4c7f-4850-a6f3-8bc4b0189408	+
\.


--
-- TOC entry 3902 (class 2606 OID 43132)
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- TOC entry 3756 (class 2606 OID 43134)
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- TOC entry 3643 (class 2606 OID 43136)
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- TOC entry 3658 (class 2606 OID 43138)
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- TOC entry 3645 (class 2606 OID 43140)
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- TOC entry 3791 (class 2606 OID 43142)
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- TOC entry 3633 (class 2606 OID 43144)
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- TOC entry 3677 (class 2606 OID 43146)
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- TOC entry 3683 (class 2606 OID 43148)
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- TOC entry 3679 (class 2606 OID 43150)
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- TOC entry 3720 (class 2606 OID 43152)
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- TOC entry 3702 (class 2606 OID 43154)
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- TOC entry 3705 (class 2606 OID 43156)
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- TOC entry 3712 (class 2606 OID 43158)
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- TOC entry 3716 (class 2606 OID 43160)
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- TOC entry 3724 (class 2606 OID 43162)
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- TOC entry 3732 (class 2606 OID 43164)
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- TOC entry 3793 (class 2606 OID 43166)
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- TOC entry 3796 (class 2606 OID 43168)
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- TOC entry 3799 (class 2606 OID 43170)
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- TOC entry 3808 (class 2606 OID 43172)
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- TOC entry 3740 (class 2606 OID 43174)
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- TOC entry 3640 (class 2606 OID 43176)
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- TOC entry 3699 (class 2606 OID 43178)
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- TOC entry 3728 (class 2606 OID 43180)
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- TOC entry 3783 (class 2606 OID 43182)
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- TOC entry 3675 (class 2606 OID 43184)
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- TOC entry 3898 (class 2606 OID 43186)
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- TOC entry 3886 (class 2606 OID 43188)
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- TOC entry 3671 (class 2606 OID 43190)
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- TOC entry 3635 (class 2606 OID 43192)
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- TOC entry 3666 (class 2606 OID 43194)
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- TOC entry 3853 (class 2606 OID 43196)
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- TOC entry 3648 (class 2606 OID 43198)
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- TOC entry 3788 (class 2606 OID 43200)
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- TOC entry 3804 (class 2606 OID 43202)
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- TOC entry 3758 (class 2606 OID 43204)
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- TOC entry 3616 (class 2606 OID 43206)
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- TOC entry 3631 (class 2606 OID 43208)
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- TOC entry 3621 (class 2606 OID 43210)
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- TOC entry 3625 (class 2606 OID 43212)
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- TOC entry 3628 (class 2606 OID 43214)
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- TOC entry 3669 (class 2606 OID 43216)
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- TOC entry 3895 (class 2606 OID 43218)
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- TOC entry 3686 (class 2606 OID 43220)
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- TOC entry 3673 (class 2606 OID 43222)
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- TOC entry 3745 (class 2606 OID 43224)
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- TOC entry 3775 (class 2606 OID 43226)
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- TOC entry 3806 (class 2606 OID 43228)
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- TOC entry 3690 (class 2606 OID 43230)
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- TOC entry 3878 (class 2606 OID 43232)
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- TOC entry 3829 (class 2606 OID 43234)
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- TOC entry 3838 (class 2606 OID 43236)
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- TOC entry 3833 (class 2606 OID 43238)
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- TOC entry 3618 (class 2606 OID 43240)
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- TOC entry 3821 (class 2606 OID 43242)
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- TOC entry 3843 (class 2606 OID 43244)
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- TOC entry 3824 (class 2606 OID 43246)
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- TOC entry 3856 (class 2606 OID 43248)
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- TOC entry 3871 (class 2606 OID 43250)
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- TOC entry 3884 (class 2606 OID 43252)
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- TOC entry 3880 (class 2606 OID 43254)
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- TOC entry 3710 (class 2606 OID 43256)
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- TOC entry 3868 (class 2606 OID 43258)
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- TOC entry 3863 (class 2606 OID 43260)
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- TOC entry 3752 (class 2606 OID 43262)
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- TOC entry 3734 (class 2606 OID 43264)
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- TOC entry 3737 (class 2606 OID 43266)
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- TOC entry 3747 (class 2606 OID 43268)
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- TOC entry 3750 (class 2606 OID 43270)
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- TOC entry 3762 (class 2606 OID 43272)
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- TOC entry 3765 (class 2606 OID 43274)
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- TOC entry 3769 (class 2606 OID 43276)
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- TOC entry 3777 (class 2606 OID 43278)
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- TOC entry 3781 (class 2606 OID 43280)
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- TOC entry 3811 (class 2606 OID 43282)
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- TOC entry 3814 (class 2606 OID 43284)
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- TOC entry 3816 (class 2606 OID 43286)
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- TOC entry 3892 (class 2606 OID 43288)
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- TOC entry 3848 (class 2606 OID 43290)
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- TOC entry 3850 (class 2606 OID 43292)
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- TOC entry 3859 (class 2606 OID 43294)
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- TOC entry 3889 (class 2606 OID 43296)
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- TOC entry 3900 (class 2606 OID 43298)
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- TOC entry 3904 (class 2606 OID 43300)
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- TOC entry 3656 (class 2606 OID 43302)
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- TOC entry 3651 (class 2606 OID 43304)
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- TOC entry 3693 (class 2606 OID 43306)
-- Name: databasechangeloglock pk_databasechangeloglock; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT pk_databasechangeloglock PRIMARY KEY (id);


--
-- TOC entry 3827 (class 2606 OID 43308)
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- TOC entry 3664 (class 2606 OID 43310)
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- TOC entry 3697 (class 2606 OID 43312)
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- TOC entry 3802 (class 2606 OID 43314)
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- TOC entry 3819 (class 2606 OID 43316)
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- TOC entry 3754 (class 2606 OID 43318)
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- TOC entry 3743 (class 2606 OID 43320)
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- TOC entry 3638 (class 2606 OID 43322)
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- TOC entry 3653 (class 2606 OID 43324)
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- TOC entry 3874 (class 2606 OID 43326)
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- TOC entry 3841 (class 2606 OID 43328)
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- TOC entry 3831 (class 2606 OID 43330)
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- TOC entry 3836 (class 2606 OID 43332)
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- TOC entry 3846 (class 2606 OID 43334)
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- TOC entry 3866 (class 2606 OID 43336)
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- TOC entry 3786 (class 2606 OID 43338)
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- TOC entry 3876 (class 2606 OID 43340)
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- TOC entry 3619 (class 1259 OID 43341)
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- TOC entry 3629 (class 1259 OID 43342)
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- TOC entry 3622 (class 1259 OID 43343)
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- TOC entry 3623 (class 1259 OID 43344)
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- TOC entry 3626 (class 1259 OID 43345)
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- TOC entry 3659 (class 1259 OID 43346)
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- TOC entry 3641 (class 1259 OID 43347)
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, value);


--
-- TOC entry 3636 (class 1259 OID 43348)
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- TOC entry 3646 (class 1259 OID 43349)
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- TOC entry 3667 (class 1259 OID 43350)
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- TOC entry 3654 (class 1259 OID 43351)
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- TOC entry 3660 (class 1259 OID 43352)
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- TOC entry 3778 (class 1259 OID 43353)
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- TOC entry 3661 (class 1259 OID 43354)
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- TOC entry 3684 (class 1259 OID 43355)
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- TOC entry 3680 (class 1259 OID 43356)
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- TOC entry 3681 (class 1259 OID 43357)
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- TOC entry 3687 (class 1259 OID 43358)
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- TOC entry 3688 (class 1259 OID 43359)
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- TOC entry 3694 (class 1259 OID 43360)
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- TOC entry 3695 (class 1259 OID 43361)
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- TOC entry 3700 (class 1259 OID 43362)
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- TOC entry 3729 (class 1259 OID 43363)
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- TOC entry 3730 (class 1259 OID 43364)
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- TOC entry 3703 (class 1259 OID 43365)
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- TOC entry 3706 (class 1259 OID 43366)
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- TOC entry 3707 (class 1259 OID 43367)
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- TOC entry 3708 (class 1259 OID 43368)
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- TOC entry 3713 (class 1259 OID 43369)
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- TOC entry 3714 (class 1259 OID 43370)
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- TOC entry 3717 (class 1259 OID 43371)
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- TOC entry 3718 (class 1259 OID 43372)
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- TOC entry 3721 (class 1259 OID 43373)
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- TOC entry 3722 (class 1259 OID 43374)
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- TOC entry 3725 (class 1259 OID 43375)
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- TOC entry 3726 (class 1259 OID 43376)
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- TOC entry 3735 (class 1259 OID 43377)
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- TOC entry 3738 (class 1259 OID 43378)
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- TOC entry 3748 (class 1259 OID 43379)
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- TOC entry 3741 (class 1259 OID 43380)
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- TOC entry 3759 (class 1259 OID 43381)
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- TOC entry 3760 (class 1259 OID 43382)
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- TOC entry 3766 (class 1259 OID 43383)
-- Name: idx_offline_css_preload; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_css_preload ON public.offline_client_session USING btree (client_id, offline_flag);


--
-- TOC entry 3770 (class 1259 OID 43384)
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- TOC entry 3771 (class 1259 OID 43385)
-- Name: idx_offline_uss_by_usersess; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_by_usersess ON public.offline_user_session USING btree (realm_id, offline_flag, user_session_id);


--
-- TOC entry 3772 (class 1259 OID 43386)
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_createdon ON public.offline_user_session USING btree (created_on);


--
-- TOC entry 3773 (class 1259 OID 43387)
-- Name: idx_offline_uss_preload; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_preload ON public.offline_user_session USING btree (offline_flag, created_on, user_session_id);


--
-- TOC entry 3779 (class 1259 OID 43388)
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- TOC entry 3789 (class 1259 OID 43389)
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- TOC entry 3649 (class 1259 OID 43390)
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- TOC entry 3794 (class 1259 OID 43391)
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- TOC entry 3800 (class 1259 OID 43392)
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- TOC entry 3797 (class 1259 OID 43393)
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- TOC entry 3784 (class 1259 OID 43394)
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- TOC entry 3809 (class 1259 OID 43395)
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- TOC entry 3812 (class 1259 OID 43396)
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- TOC entry 3817 (class 1259 OID 43397)
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- TOC entry 3822 (class 1259 OID 43398)
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- TOC entry 3825 (class 1259 OID 43399)
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- TOC entry 3834 (class 1259 OID 43400)
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- TOC entry 3839 (class 1259 OID 43401)
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- TOC entry 3844 (class 1259 OID 43402)
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- TOC entry 3851 (class 1259 OID 43403)
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- TOC entry 3662 (class 1259 OID 43404)
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- TOC entry 3854 (class 1259 OID 43405)
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- TOC entry 3857 (class 1259 OID 43406)
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- TOC entry 3763 (class 1259 OID 43407)
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- TOC entry 3767 (class 1259 OID 43408)
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- TOC entry 3869 (class 1259 OID 43409)
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- TOC entry 3860 (class 1259 OID 43410)
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- TOC entry 3861 (class 1259 OID 43411)
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- TOC entry 3864 (class 1259 OID 43412)
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- TOC entry 3691 (class 1259 OID 43413)
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- TOC entry 3872 (class 1259 OID 43414)
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- TOC entry 3890 (class 1259 OID 43415)
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- TOC entry 3893 (class 1259 OID 43416)
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- TOC entry 3896 (class 1259 OID 43417)
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- TOC entry 3881 (class 1259 OID 43418)
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- TOC entry 3882 (class 1259 OID 43419)
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- TOC entry 3887 (class 1259 OID 43420)
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- TOC entry 3905 (class 1259 OID 43421)
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- TOC entry 3918 (class 2606 OID 43422)
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- TOC entry 3932 (class 2606 OID 43427)
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3912 (class 2606 OID 43432)
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3929 (class 2606 OID 43437)
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3914 (class 2606 OID 43442)
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3919 (class 2606 OID 43447)
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- TOC entry 3978 (class 2606 OID 43452)
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- TOC entry 3921 (class 2606 OID 43457)
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- TOC entry 3948 (class 2606 OID 43462)
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3974 (class 2606 OID 43467)
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3920 (class 2606 OID 43472)
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- TOC entry 3945 (class 2606 OID 43477)
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3950 (class 2606 OID 43482)
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 3967 (class 2606 OID 43487)
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3976 (class 2606 OID 43492)
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3936 (class 2606 OID 43497)
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- TOC entry 3946 (class 2606 OID 43502)
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3941 (class 2606 OID 43507)
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3925 (class 2606 OID 43512)
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- TOC entry 3908 (class 2606 OID 43517)
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- TOC entry 3909 (class 2606 OID 43522)
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3910 (class 2606 OID 43527)
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3911 (class 2606 OID 43532)
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3917 (class 2606 OID 43537)
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- TOC entry 3977 (class 2606 OID 43542)
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3915 (class 2606 OID 43547)
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- TOC entry 3916 (class 2606 OID 43552)
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- TOC entry 3922 (class 2606 OID 43557)
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- TOC entry 3938 (class 2606 OID 43562)
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- TOC entry 3913 (class 2606 OID 43567)
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3924 (class 2606 OID 43572)
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- TOC entry 3923 (class 2606 OID 43577)
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3942 (class 2606 OID 43582)
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3973 (class 2606 OID 43587)
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- TOC entry 3971 (class 2606 OID 43592)
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- TOC entry 3972 (class 2606 OID 43597)
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3906 (class 2606 OID 43602)
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3965 (class 2606 OID 43607)
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3955 (class 2606 OID 43612)
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- TOC entry 3960 (class 2606 OID 43617)
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- TOC entry 3956 (class 2606 OID 43622)
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 3957 (class 2606 OID 43627)
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- TOC entry 3907 (class 2606 OID 43632)
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3966 (class 2606 OID 43637)
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- TOC entry 3958 (class 2606 OID 43642)
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3959 (class 2606 OID 43647)
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- TOC entry 3953 (class 2606 OID 43652)
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 3951 (class 2606 OID 43657)
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 3952 (class 2606 OID 43662)
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3954 (class 2606 OID 43667)
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- TOC entry 3961 (class 2606 OID 43672)
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- TOC entry 3926 (class 2606 OID 43677)
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- TOC entry 3969 (class 2606 OID 43682)
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- TOC entry 3968 (class 2606 OID 43687)
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3930 (class 2606 OID 43692)
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- TOC entry 3931 (class 2606 OID 43697)
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- TOC entry 3943 (class 2606 OID 43702)
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3944 (class 2606 OID 43707)
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3934 (class 2606 OID 43712)
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3935 (class 2606 OID 43717)
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- TOC entry 3979 (class 2606 OID 43722)
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3964 (class 2606 OID 43727)
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3939 (class 2606 OID 43732)
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3927 (class 2606 OID 43737)
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3940 (class 2606 OID 43742)
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- TOC entry 3928 (class 2606 OID 43747)
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3949 (class 2606 OID 43752)
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3962 (class 2606 OID 43757)
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 3963 (class 2606 OID 43762)
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- TOC entry 3947 (class 2606 OID 43767)
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3970 (class 2606 OID 43772)
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- TOC entry 3975 (class 2606 OID 43777)
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3937 (class 2606 OID 43782)
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3933 (class 2606 OID 43787)
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


-- Completed on 2022-03-15 14:50:19

--
-- PostgreSQL database dump complete
--

