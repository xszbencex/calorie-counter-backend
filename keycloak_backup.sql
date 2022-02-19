--
-- PostgreSQL database dump
--

-- Dumped from database version 14.1 (Debian 14.1-1.pgdg110+1)
-- Dumped by pg_dump version 14.1 (Debian 14.1-1.pgdg110+1)

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
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: client; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    value character varying(4000),
    name character varying(255) NOT NULL
);


--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


--
-- Name: client_session; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


--
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


--
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


--
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


--
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


--
-- Name: component; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: component_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(4000)
);


--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


--
-- Name: credential; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024)
);


--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36)
);


--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


--
-- Name: realm; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode character varying(15) NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL
);


--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


--
-- Name: user_session; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: -
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
9a7df0dc-cf6b-402b-9357-be5a75ddb773	\N	auth-cookie	MAG	1d84df76-7e1e-4a9e-b73d-73e4407c683b	2	10	f	\N	\N
f91cebe4-5afe-4618-ab26-4d8e7385def2	\N	auth-spnego	MAG	1d84df76-7e1e-4a9e-b73d-73e4407c683b	3	20	f	\N	\N
03814d74-481b-486d-9157-d8e22ec313ad	\N	identity-provider-redirector	MAG	1d84df76-7e1e-4a9e-b73d-73e4407c683b	2	25	f	\N	\N
81a3e896-7e0f-4285-b308-d5b90449e698	\N	\N	MAG	1d84df76-7e1e-4a9e-b73d-73e4407c683b	2	30	t	c6d7af3d-cb91-445d-bc70-6318fa7562fc	\N
04fc7547-6ea0-41ee-b1f3-899c708f71bc	\N	auth-username-password-form	MAG	c6d7af3d-cb91-445d-bc70-6318fa7562fc	0	10	f	\N	\N
0af6aa91-0502-4d1d-aee7-c584e871d037	\N	\N	MAG	c6d7af3d-cb91-445d-bc70-6318fa7562fc	1	20	t	eeecdac3-9c73-4e1f-8ee9-58c30ade7afa	\N
456642c0-89f8-4fa0-bba1-c4744fa90bc9	\N	conditional-user-configured	MAG	eeecdac3-9c73-4e1f-8ee9-58c30ade7afa	0	10	f	\N	\N
aea2889e-a354-4ee6-83e9-2583ec075dc3	\N	auth-otp-form	MAG	eeecdac3-9c73-4e1f-8ee9-58c30ade7afa	0	20	f	\N	\N
7ac04fe6-6b79-4c8c-85b2-779e23fa0528	\N	direct-grant-validate-username	MAG	dd2f7d23-e7db-441d-b891-2d228aba1724	0	10	f	\N	\N
92a3b23c-a300-4ad5-bb56-9631439309cc	\N	direct-grant-validate-password	MAG	dd2f7d23-e7db-441d-b891-2d228aba1724	0	20	f	\N	\N
0db5c6ac-c46b-4d9c-89e9-d4cf9123800d	\N	\N	MAG	dd2f7d23-e7db-441d-b891-2d228aba1724	1	30	t	9c4a8f5d-9962-4e32-8c26-01403153da3c	\N
3aea669d-38cf-4f3e-a631-40bb8f426a9d	\N	conditional-user-configured	MAG	9c4a8f5d-9962-4e32-8c26-01403153da3c	0	10	f	\N	\N
b587c3b8-e465-4520-a013-0e79ef200ea2	\N	direct-grant-validate-otp	MAG	9c4a8f5d-9962-4e32-8c26-01403153da3c	0	20	f	\N	\N
a6ece93b-5d01-45bf-b589-d6e7e98cabd9	\N	registration-page-form	MAG	5b999054-9538-4ccd-a5b0-a0b38fba68c4	0	10	t	e6b84a2b-b456-4ffe-ab28-8fb147d27e11	\N
d68d4d55-3ab3-4653-bb18-30368a39ebd6	\N	registration-user-creation	MAG	e6b84a2b-b456-4ffe-ab28-8fb147d27e11	0	20	f	\N	\N
14464964-20d6-4e0f-8654-c01cf2cd8511	\N	registration-profile-action	MAG	e6b84a2b-b456-4ffe-ab28-8fb147d27e11	0	40	f	\N	\N
cf99063e-768a-40e5-ad9d-fc29ce9fb85d	\N	registration-password-action	MAG	e6b84a2b-b456-4ffe-ab28-8fb147d27e11	0	50	f	\N	\N
724b14b4-0c24-4551-b2c2-d0bd3bc22b02	\N	registration-recaptcha-action	MAG	e6b84a2b-b456-4ffe-ab28-8fb147d27e11	3	60	f	\N	\N
d863a164-a314-409e-a202-6c793be7ebe4	\N	reset-credentials-choose-user	MAG	da260cbb-64f4-4ebe-81a5-7a18b9d2daaf	0	10	f	\N	\N
cb55bdb6-b3e6-43d2-a96f-72f68894b1bb	\N	reset-credential-email	MAG	da260cbb-64f4-4ebe-81a5-7a18b9d2daaf	0	20	f	\N	\N
47ee1933-41c1-49a5-8d92-49ee24108215	\N	reset-password	MAG	da260cbb-64f4-4ebe-81a5-7a18b9d2daaf	0	30	f	\N	\N
c6046dca-5489-47f9-8b78-f53526ffdc6c	\N	\N	MAG	da260cbb-64f4-4ebe-81a5-7a18b9d2daaf	1	40	t	4a028a7c-8928-4304-b4e8-06648353c8ad	\N
85f4c358-2792-4122-a1b5-87cd43becf6e	\N	conditional-user-configured	MAG	4a028a7c-8928-4304-b4e8-06648353c8ad	0	10	f	\N	\N
753a2f03-37b6-4479-a7ad-e5e818af108c	\N	reset-otp	MAG	4a028a7c-8928-4304-b4e8-06648353c8ad	0	20	f	\N	\N
3641b73b-4e4f-48b1-a78e-c92ffc5573f5	\N	client-secret	MAG	8c20b949-dcbf-44e9-82ab-2ef4481203a7	2	10	f	\N	\N
67df4272-83e0-4d3d-b99b-ecbccd9faf6b	\N	client-jwt	MAG	8c20b949-dcbf-44e9-82ab-2ef4481203a7	2	20	f	\N	\N
0dbcac5f-49d6-46ad-aa0d-5677f87b10a2	\N	client-secret-jwt	MAG	8c20b949-dcbf-44e9-82ab-2ef4481203a7	2	30	f	\N	\N
334a9f3f-5801-49d9-ad2e-65fb0a4cd0b4	\N	client-x509	MAG	8c20b949-dcbf-44e9-82ab-2ef4481203a7	2	40	f	\N	\N
af36c38e-b7a3-4aec-a653-535a62c6b9e2	\N	idp-review-profile	MAG	ce416ed1-0826-450a-ba35-a09db453baf4	0	10	f	\N	91cd6abf-250d-4dab-81ca-e7bf6bf7c32e
2084fc3b-752b-403a-b726-40208aec7390	\N	\N	MAG	ce416ed1-0826-450a-ba35-a09db453baf4	0	20	t	37a5250f-7bb5-4b89-8a29-ff36390f4222	\N
6745cdba-19e1-4510-aca1-ed235a8ee26e	\N	idp-create-user-if-unique	MAG	37a5250f-7bb5-4b89-8a29-ff36390f4222	2	10	f	\N	0190e921-92ff-4791-9698-d26af73046e1
f7f4a304-3e86-4a37-9caa-b382c215bb9d	\N	\N	MAG	37a5250f-7bb5-4b89-8a29-ff36390f4222	2	20	t	27f992b6-7010-4da7-b958-37e4fc2b9414	\N
1a456ac6-a709-4be0-a6b9-3ab0fb2f2191	\N	idp-confirm-link	MAG	27f992b6-7010-4da7-b958-37e4fc2b9414	0	10	f	\N	\N
16d11fe0-a598-4514-b38f-33b9a2445aef	\N	\N	MAG	27f992b6-7010-4da7-b958-37e4fc2b9414	0	20	t	0bc568c4-01d3-4dd4-ad16-965df8400e99	\N
2cb75a2c-6ceb-483d-8bf4-ef60e4fef304	\N	idp-email-verification	MAG	0bc568c4-01d3-4dd4-ad16-965df8400e99	2	10	f	\N	\N
796f2183-0750-4264-b3fa-4120380fe46d	\N	\N	MAG	0bc568c4-01d3-4dd4-ad16-965df8400e99	2	20	t	22274523-4a40-4ab8-be65-edd72b81c850	\N
3171f0e9-105d-472f-9bf4-23541b831ba1	\N	idp-username-password-form	MAG	22274523-4a40-4ab8-be65-edd72b81c850	0	10	f	\N	\N
8e05fc01-98dd-41cc-9f6a-21ddb3fe68ef	\N	\N	MAG	22274523-4a40-4ab8-be65-edd72b81c850	1	20	t	9662f01c-a52f-455f-903a-399e2c798c6a	\N
235d3831-fd67-4680-8c87-d4e90de898d3	\N	conditional-user-configured	MAG	9662f01c-a52f-455f-903a-399e2c798c6a	0	10	f	\N	\N
0d1c27ba-48f1-4013-afbb-02bb255002af	\N	auth-otp-form	MAG	9662f01c-a52f-455f-903a-399e2c798c6a	0	20	f	\N	\N
0853a4c6-97f0-468a-aa64-41ca1d73644e	\N	http-basic-authenticator	MAG	0536ec2f-25ed-4de3-bfa3-52ba1ede23ce	0	10	f	\N	\N
3845c95f-88c3-4ea3-8abb-ca85c1a71ebd	\N	docker-http-basic-authenticator	MAG	1abc0bb6-7d1c-47df-a9e5-0975a15f5b04	0	10	f	\N	\N
c65e3ca0-64cb-4d75-838e-0ac6d50eb6e1	\N	no-cookie-redirect	MAG	11bd1c4a-676b-41dc-9bbe-f29943a875df	0	10	f	\N	\N
46f54a13-234f-42e6-9c7c-70dd52848878	\N	\N	MAG	11bd1c4a-676b-41dc-9bbe-f29943a875df	0	20	t	daf8860c-1efc-45fa-97fa-bd8290388d65	\N
923a0f4b-5398-4c21-988e-c741d8f1c575	\N	basic-auth	MAG	daf8860c-1efc-45fa-97fa-bd8290388d65	0	10	f	\N	\N
19c8a8d6-9a79-4f04-9fa8-2af0cdcb809e	\N	basic-auth-otp	MAG	daf8860c-1efc-45fa-97fa-bd8290388d65	3	20	f	\N	\N
f8e2a48b-b810-457d-89b3-56139159e140	\N	auth-spnego	MAG	daf8860c-1efc-45fa-97fa-bd8290388d65	3	30	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: -
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
1d84df76-7e1e-4a9e-b73d-73e4407c683b	browser	browser based authentication	MAG	basic-flow	t	t
c6d7af3d-cb91-445d-bc70-6318fa7562fc	forms	Username, password, otp and other auth forms.	MAG	basic-flow	f	t
eeecdac3-9c73-4e1f-8ee9-58c30ade7afa	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	MAG	basic-flow	f	t
dd2f7d23-e7db-441d-b891-2d228aba1724	direct grant	OpenID Connect Resource Owner Grant	MAG	basic-flow	t	t
9c4a8f5d-9962-4e32-8c26-01403153da3c	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	MAG	basic-flow	f	t
5b999054-9538-4ccd-a5b0-a0b38fba68c4	registration	registration flow	MAG	basic-flow	t	t
e6b84a2b-b456-4ffe-ab28-8fb147d27e11	registration form	registration form	MAG	form-flow	f	t
da260cbb-64f4-4ebe-81a5-7a18b9d2daaf	reset credentials	Reset credentials for a user if they forgot their password or something	MAG	basic-flow	t	t
4a028a7c-8928-4304-b4e8-06648353c8ad	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	MAG	basic-flow	f	t
8c20b949-dcbf-44e9-82ab-2ef4481203a7	clients	Base authentication for clients	MAG	client-flow	t	t
ce416ed1-0826-450a-ba35-a09db453baf4	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	MAG	basic-flow	t	t
37a5250f-7bb5-4b89-8a29-ff36390f4222	User creation or linking	Flow for the existing/non-existing user alternatives	MAG	basic-flow	f	t
27f992b6-7010-4da7-b958-37e4fc2b9414	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	MAG	basic-flow	f	t
0bc568c4-01d3-4dd4-ad16-965df8400e99	Account verification options	Method with which to verity the existing account	MAG	basic-flow	f	t
22274523-4a40-4ab8-be65-edd72b81c850	Verify Existing Account by Re-authentication	Reauthentication of existing account	MAG	basic-flow	f	t
9662f01c-a52f-455f-903a-399e2c798c6a	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	MAG	basic-flow	f	t
0536ec2f-25ed-4de3-bfa3-52ba1ede23ce	saml ecp	SAML ECP Profile Authentication Flow	MAG	basic-flow	t	t
1abc0bb6-7d1c-47df-a9e5-0975a15f5b04	docker auth	Used by Docker clients to authenticate against the IDP	MAG	basic-flow	t	t
11bd1c4a-676b-41dc-9bbe-f29943a875df	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	MAG	basic-flow	t	t
daf8860c-1efc-45fa-97fa-bd8290388d65	Authentication Options	Authentication options.	MAG	basic-flow	f	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
3e966fe1-1409-4d83-a21c-1b9635283935	review profile config	master
6e77f69c-05fc-40fc-8fef-984168a93bfe	create unique user config	master
91cd6abf-250d-4dab-81ca-e7bf6bf7c32e	review profile config	MAG
0190e921-92ff-4791-9698-d26af73046e1	create unique user config	MAG
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
3e966fe1-1409-4d83-a21c-1b9635283935	missing	update.profile.on.first.login
6e77f69c-05fc-40fc-8fef-984168a93bfe	false	require.password.update.after.registration
91cd6abf-250d-4dab-81ca-e7bf6bf7c32e	missing	update.profile.on.first.login
0190e921-92ff-4791-9698-d26af73046e1	false	require.password.update.after.registration
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
afddb56d-0c09-4bb5-ba70-3d594f19d404	t	f	master-realm	0	f	\N	\N	t	\N	f	master	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
df754331-dc4c-4886-aa39-4a7ac747b383	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	master	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
8433c1fd-5ede-4535-a056-2e4b8c0a289a	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	master	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
b4c6f356-3437-48fd-9b9b-0d7a0465ae07	t	f	broker	0	f	\N	\N	t	\N	f	master	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
9b7ac9ff-5213-44a3-988c-a6f181f31507	t	f	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	master	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
2a6f9e64-2bdd-4928-a565-ebc71d92bb90	t	f	admin-cli	0	t	\N	\N	f	\N	f	master	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
5f12ca42-1560-4c3a-bd42-ac550e7d341c	t	f	MAG-realm	0	f	\N	\N	t	\N	f	master	\N	0	f	f	MAG Realm	f	client-secret	\N	\N	\N	t	f	f	f
57d0ab0d-d25b-4b1d-91ee-1ed79754e651	t	f	realm-management	0	f	\N	\N	t	\N	f	MAG	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
006df867-19d0-4bbc-9de7-f01ca96aaf7a	t	f	account	0	t	\N	/realms/MAG/account/	f	\N	f	MAG	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
87ae7e2b-85a5-4f5c-a55b-4596d7dd3baa	t	f	account-console	0	t	\N	/realms/MAG/account/	f	\N	f	MAG	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
dcfd7631-d53e-4bce-b337-40ec363a561e	t	f	broker	0	f	\N	\N	t	\N	f	MAG	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
f0f69f18-4c7f-4850-a6f3-8bc4b0189408	t	f	security-admin-console	0	t	\N	/admin/MAG/console/	f	\N	f	MAG	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
7c2584c8-c873-46c2-a06f-5d9fbea99100	t	f	admin-cli	0	t	\N	\N	f	\N	f	MAG	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
0ac48ba0-1e20-4236-8749-bed43d1a2737	t	t	login	0	t	\N	\N	f	\N	f	MAG	openid-connect	-1	f	f	\N	f	client-secret	\N	\N	\N	t	f	t	f
99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	t	t	admin-mag	0	f	0d88f7c6-97e3-4a25-94fa-5b0c322a093d	\N	f	\N	f	MAG	openid-connect	-1	f	f	\N	t	client-secret	\N	\N	\N	f	f	f	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_attributes (client_id, value, name) FROM stdin;
8433c1fd-5ede-4535-a056-2e4b8c0a289a	S256	pkce.code.challenge.method
9b7ac9ff-5213-44a3-988c-a6f181f31507	S256	pkce.code.challenge.method
87ae7e2b-85a5-4f5c-a55b-4596d7dd3baa	S256	pkce.code.challenge.method
f0f69f18-4c7f-4850-a6f3-8bc4b0189408	S256	pkce.code.challenge.method
0ac48ba0-1e20-4236-8749-bed43d1a2737	true	backchannel.logout.session.required
0ac48ba0-1e20-4236-8749-bed43d1a2737	false	backchannel.logout.revoke.offline.tokens
0ac48ba0-1e20-4236-8749-bed43d1a2737	false	saml.artifact.binding
0ac48ba0-1e20-4236-8749-bed43d1a2737	false	saml.server.signature
0ac48ba0-1e20-4236-8749-bed43d1a2737	false	saml.server.signature.keyinfo.ext
0ac48ba0-1e20-4236-8749-bed43d1a2737	false	saml.assertion.signature
0ac48ba0-1e20-4236-8749-bed43d1a2737	false	saml.client.signature
0ac48ba0-1e20-4236-8749-bed43d1a2737	false	saml.encrypt
0ac48ba0-1e20-4236-8749-bed43d1a2737	false	saml.authnstatement
0ac48ba0-1e20-4236-8749-bed43d1a2737	false	saml.onetimeuse.condition
0ac48ba0-1e20-4236-8749-bed43d1a2737	false	saml_force_name_id_format
0ac48ba0-1e20-4236-8749-bed43d1a2737	false	saml.multivalued.roles
0ac48ba0-1e20-4236-8749-bed43d1a2737	false	saml.force.post.binding
0ac48ba0-1e20-4236-8749-bed43d1a2737	false	exclude.session.state.from.auth.response
0ac48ba0-1e20-4236-8749-bed43d1a2737	false	oauth2.device.authorization.grant.enabled
0ac48ba0-1e20-4236-8749-bed43d1a2737	false	oidc.ciba.grant.enabled
0ac48ba0-1e20-4236-8749-bed43d1a2737	true	use.refresh.tokens
0ac48ba0-1e20-4236-8749-bed43d1a2737	false	id.token.as.detached.signature
0ac48ba0-1e20-4236-8749-bed43d1a2737	false	tls.client.certificate.bound.access.tokens
0ac48ba0-1e20-4236-8749-bed43d1a2737	false	client_credentials.use_refresh_token
0ac48ba0-1e20-4236-8749-bed43d1a2737	false	display.on.consent.screen
99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	true	backchannel.logout.session.required
99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	false	backchannel.logout.revoke.offline.tokens
99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	false	saml.artifact.binding
99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	false	saml.server.signature
99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	false	saml.server.signature.keyinfo.ext
99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	false	saml.assertion.signature
99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	false	saml.client.signature
99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	false	saml.encrypt
99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	false	saml.authnstatement
99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	false	saml.onetimeuse.condition
99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	false	saml_force_name_id_format
99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	false	saml.multivalued.roles
99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	false	saml.force.post.binding
99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	false	exclude.session.state.from.auth.response
99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	false	oauth2.device.authorization.grant.enabled
99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	false	oidc.ciba.grant.enabled
99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	true	use.refresh.tokens
99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	false	id.token.as.detached.signature
99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	false	tls.client.certificate.bound.access.tokens
99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	false	client_credentials.use_refresh_token
99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	false	display.on.consent.screen
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: -
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
c15c5363-490a-48d2-9edf-b12d8669b7cf	offline_access	MAG	OpenID Connect built-in scope: offline_access	openid-connect
fc4ba834-d258-4deb-9b04-5dac5518559a	role_list	MAG	SAML role list	saml
13ac6628-4572-4335-a50c-2761c21c3cc0	profile	MAG	OpenID Connect built-in scope: profile	openid-connect
0fb0feeb-c8d3-4a65-889d-fd69ce493eab	email	MAG	OpenID Connect built-in scope: email	openid-connect
4cf73263-9888-43d5-af5b-fc70ea4b99be	address	MAG	OpenID Connect built-in scope: address	openid-connect
72d38159-ce38-477d-b26a-695d1be288d8	phone	MAG	OpenID Connect built-in scope: phone	openid-connect
708c7fd8-1731-4cf9-8ea2-5b3bb57d65d6	roles	MAG	OpenID Connect scope for add user roles to the access token	openid-connect
323bbbd8-2c6c-4080-a351-7f4cf8fd42b2	web-origins	MAG	OpenID Connect scope for add allowed web origins to the access token	openid-connect
bcca4bf3-80df-4c1c-9394-36b7263928b8	microprofile-jwt	MAG	Microprofile - JWT built-in scope	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: -
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
c15c5363-490a-48d2-9edf-b12d8669b7cf	true	display.on.consent.screen
c15c5363-490a-48d2-9edf-b12d8669b7cf	${offlineAccessScopeConsentText}	consent.screen.text
fc4ba834-d258-4deb-9b04-5dac5518559a	true	display.on.consent.screen
fc4ba834-d258-4deb-9b04-5dac5518559a	${samlRoleListScopeConsentText}	consent.screen.text
13ac6628-4572-4335-a50c-2761c21c3cc0	true	display.on.consent.screen
13ac6628-4572-4335-a50c-2761c21c3cc0	${profileScopeConsentText}	consent.screen.text
13ac6628-4572-4335-a50c-2761c21c3cc0	true	include.in.token.scope
0fb0feeb-c8d3-4a65-889d-fd69ce493eab	true	display.on.consent.screen
0fb0feeb-c8d3-4a65-889d-fd69ce493eab	${emailScopeConsentText}	consent.screen.text
0fb0feeb-c8d3-4a65-889d-fd69ce493eab	true	include.in.token.scope
4cf73263-9888-43d5-af5b-fc70ea4b99be	true	display.on.consent.screen
4cf73263-9888-43d5-af5b-fc70ea4b99be	${addressScopeConsentText}	consent.screen.text
4cf73263-9888-43d5-af5b-fc70ea4b99be	true	include.in.token.scope
72d38159-ce38-477d-b26a-695d1be288d8	true	display.on.consent.screen
72d38159-ce38-477d-b26a-695d1be288d8	${phoneScopeConsentText}	consent.screen.text
72d38159-ce38-477d-b26a-695d1be288d8	true	include.in.token.scope
708c7fd8-1731-4cf9-8ea2-5b3bb57d65d6	true	display.on.consent.screen
708c7fd8-1731-4cf9-8ea2-5b3bb57d65d6	${rolesScopeConsentText}	consent.screen.text
708c7fd8-1731-4cf9-8ea2-5b3bb57d65d6	false	include.in.token.scope
323bbbd8-2c6c-4080-a351-7f4cf8fd42b2	false	display.on.consent.screen
323bbbd8-2c6c-4080-a351-7f4cf8fd42b2		consent.screen.text
323bbbd8-2c6c-4080-a351-7f4cf8fd42b2	false	include.in.token.scope
bcca4bf3-80df-4c1c-9394-36b7263928b8	false	display.on.consent.screen
bcca4bf3-80df-4c1c-9394-36b7263928b8	true	include.in.token.scope
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: -
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
006df867-19d0-4bbc-9de7-f01ca96aaf7a	13ac6628-4572-4335-a50c-2761c21c3cc0	t
006df867-19d0-4bbc-9de7-f01ca96aaf7a	0fb0feeb-c8d3-4a65-889d-fd69ce493eab	t
006df867-19d0-4bbc-9de7-f01ca96aaf7a	323bbbd8-2c6c-4080-a351-7f4cf8fd42b2	t
006df867-19d0-4bbc-9de7-f01ca96aaf7a	708c7fd8-1731-4cf9-8ea2-5b3bb57d65d6	t
006df867-19d0-4bbc-9de7-f01ca96aaf7a	72d38159-ce38-477d-b26a-695d1be288d8	f
006df867-19d0-4bbc-9de7-f01ca96aaf7a	c15c5363-490a-48d2-9edf-b12d8669b7cf	f
006df867-19d0-4bbc-9de7-f01ca96aaf7a	4cf73263-9888-43d5-af5b-fc70ea4b99be	f
006df867-19d0-4bbc-9de7-f01ca96aaf7a	bcca4bf3-80df-4c1c-9394-36b7263928b8	f
87ae7e2b-85a5-4f5c-a55b-4596d7dd3baa	13ac6628-4572-4335-a50c-2761c21c3cc0	t
87ae7e2b-85a5-4f5c-a55b-4596d7dd3baa	0fb0feeb-c8d3-4a65-889d-fd69ce493eab	t
87ae7e2b-85a5-4f5c-a55b-4596d7dd3baa	323bbbd8-2c6c-4080-a351-7f4cf8fd42b2	t
87ae7e2b-85a5-4f5c-a55b-4596d7dd3baa	708c7fd8-1731-4cf9-8ea2-5b3bb57d65d6	t
87ae7e2b-85a5-4f5c-a55b-4596d7dd3baa	72d38159-ce38-477d-b26a-695d1be288d8	f
87ae7e2b-85a5-4f5c-a55b-4596d7dd3baa	c15c5363-490a-48d2-9edf-b12d8669b7cf	f
87ae7e2b-85a5-4f5c-a55b-4596d7dd3baa	4cf73263-9888-43d5-af5b-fc70ea4b99be	f
87ae7e2b-85a5-4f5c-a55b-4596d7dd3baa	bcca4bf3-80df-4c1c-9394-36b7263928b8	f
7c2584c8-c873-46c2-a06f-5d9fbea99100	13ac6628-4572-4335-a50c-2761c21c3cc0	t
7c2584c8-c873-46c2-a06f-5d9fbea99100	0fb0feeb-c8d3-4a65-889d-fd69ce493eab	t
7c2584c8-c873-46c2-a06f-5d9fbea99100	323bbbd8-2c6c-4080-a351-7f4cf8fd42b2	t
7c2584c8-c873-46c2-a06f-5d9fbea99100	708c7fd8-1731-4cf9-8ea2-5b3bb57d65d6	t
7c2584c8-c873-46c2-a06f-5d9fbea99100	72d38159-ce38-477d-b26a-695d1be288d8	f
7c2584c8-c873-46c2-a06f-5d9fbea99100	c15c5363-490a-48d2-9edf-b12d8669b7cf	f
7c2584c8-c873-46c2-a06f-5d9fbea99100	4cf73263-9888-43d5-af5b-fc70ea4b99be	f
7c2584c8-c873-46c2-a06f-5d9fbea99100	bcca4bf3-80df-4c1c-9394-36b7263928b8	f
dcfd7631-d53e-4bce-b337-40ec363a561e	13ac6628-4572-4335-a50c-2761c21c3cc0	t
dcfd7631-d53e-4bce-b337-40ec363a561e	0fb0feeb-c8d3-4a65-889d-fd69ce493eab	t
dcfd7631-d53e-4bce-b337-40ec363a561e	323bbbd8-2c6c-4080-a351-7f4cf8fd42b2	t
dcfd7631-d53e-4bce-b337-40ec363a561e	708c7fd8-1731-4cf9-8ea2-5b3bb57d65d6	t
dcfd7631-d53e-4bce-b337-40ec363a561e	72d38159-ce38-477d-b26a-695d1be288d8	f
dcfd7631-d53e-4bce-b337-40ec363a561e	c15c5363-490a-48d2-9edf-b12d8669b7cf	f
dcfd7631-d53e-4bce-b337-40ec363a561e	4cf73263-9888-43d5-af5b-fc70ea4b99be	f
dcfd7631-d53e-4bce-b337-40ec363a561e	bcca4bf3-80df-4c1c-9394-36b7263928b8	f
57d0ab0d-d25b-4b1d-91ee-1ed79754e651	13ac6628-4572-4335-a50c-2761c21c3cc0	t
57d0ab0d-d25b-4b1d-91ee-1ed79754e651	0fb0feeb-c8d3-4a65-889d-fd69ce493eab	t
57d0ab0d-d25b-4b1d-91ee-1ed79754e651	323bbbd8-2c6c-4080-a351-7f4cf8fd42b2	t
57d0ab0d-d25b-4b1d-91ee-1ed79754e651	708c7fd8-1731-4cf9-8ea2-5b3bb57d65d6	t
57d0ab0d-d25b-4b1d-91ee-1ed79754e651	72d38159-ce38-477d-b26a-695d1be288d8	f
57d0ab0d-d25b-4b1d-91ee-1ed79754e651	c15c5363-490a-48d2-9edf-b12d8669b7cf	f
57d0ab0d-d25b-4b1d-91ee-1ed79754e651	4cf73263-9888-43d5-af5b-fc70ea4b99be	f
57d0ab0d-d25b-4b1d-91ee-1ed79754e651	bcca4bf3-80df-4c1c-9394-36b7263928b8	f
f0f69f18-4c7f-4850-a6f3-8bc4b0189408	13ac6628-4572-4335-a50c-2761c21c3cc0	t
f0f69f18-4c7f-4850-a6f3-8bc4b0189408	0fb0feeb-c8d3-4a65-889d-fd69ce493eab	t
f0f69f18-4c7f-4850-a6f3-8bc4b0189408	323bbbd8-2c6c-4080-a351-7f4cf8fd42b2	t
f0f69f18-4c7f-4850-a6f3-8bc4b0189408	708c7fd8-1731-4cf9-8ea2-5b3bb57d65d6	t
f0f69f18-4c7f-4850-a6f3-8bc4b0189408	72d38159-ce38-477d-b26a-695d1be288d8	f
f0f69f18-4c7f-4850-a6f3-8bc4b0189408	c15c5363-490a-48d2-9edf-b12d8669b7cf	f
f0f69f18-4c7f-4850-a6f3-8bc4b0189408	4cf73263-9888-43d5-af5b-fc70ea4b99be	f
f0f69f18-4c7f-4850-a6f3-8bc4b0189408	bcca4bf3-80df-4c1c-9394-36b7263928b8	f
0ac48ba0-1e20-4236-8749-bed43d1a2737	13ac6628-4572-4335-a50c-2761c21c3cc0	t
0ac48ba0-1e20-4236-8749-bed43d1a2737	0fb0feeb-c8d3-4a65-889d-fd69ce493eab	t
0ac48ba0-1e20-4236-8749-bed43d1a2737	323bbbd8-2c6c-4080-a351-7f4cf8fd42b2	t
0ac48ba0-1e20-4236-8749-bed43d1a2737	708c7fd8-1731-4cf9-8ea2-5b3bb57d65d6	t
0ac48ba0-1e20-4236-8749-bed43d1a2737	72d38159-ce38-477d-b26a-695d1be288d8	f
0ac48ba0-1e20-4236-8749-bed43d1a2737	c15c5363-490a-48d2-9edf-b12d8669b7cf	f
0ac48ba0-1e20-4236-8749-bed43d1a2737	4cf73263-9888-43d5-af5b-fc70ea4b99be	f
0ac48ba0-1e20-4236-8749-bed43d1a2737	bcca4bf3-80df-4c1c-9394-36b7263928b8	f
99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	13ac6628-4572-4335-a50c-2761c21c3cc0	t
99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	0fb0feeb-c8d3-4a65-889d-fd69ce493eab	t
99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	323bbbd8-2c6c-4080-a351-7f4cf8fd42b2	t
99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	708c7fd8-1731-4cf9-8ea2-5b3bb57d65d6	t
99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	72d38159-ce38-477d-b26a-695d1be288d8	f
99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	c15c5363-490a-48d2-9edf-b12d8669b7cf	f
99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	4cf73263-9888-43d5-af5b-fc70ea4b99be	f
99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	bcca4bf3-80df-4c1c-9394-36b7263928b8	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
4af24db3-e37c-4cd7-b7b6-6ebd90e552fe	802aa55a-b52a-435a-bff2-4a3401cff9bd
c15c5363-490a-48d2-9edf-b12d8669b7cf	008360b3-9666-404c-a2ad-788147654cac
\.


--
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: -
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
81097085-6d41-4f59-abf1-0d0f7c359645	rsa-generated	MAG	rsa-generated	org.keycloak.keys.KeyProvider	MAG	\N
d02da4f3-e1ae-4499-9fb7-3b87effdfc6d	hmac-generated	MAG	hmac-generated	org.keycloak.keys.KeyProvider	MAG	\N
afece65e-a27f-407a-bcf2-f9a81a5d963c	aes-generated	MAG	aes-generated	org.keycloak.keys.KeyProvider	MAG	\N
27629b00-7708-44c4-a23b-87004e319759	Trusted Hosts	MAG	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	MAG	anonymous
9c9a4167-3f00-4c0c-9685-4ff139ebfe72	Consent Required	MAG	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	MAG	anonymous
0fd2ae25-a3f2-4ce9-91bf-73a5a6e035b8	Full Scope Disabled	MAG	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	MAG	anonymous
24ad13ce-359b-4b12-a2c5-0f3749f995e3	Max Clients Limit	MAG	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	MAG	anonymous
e6cba7a8-9e08-48ff-b512-e55270fe383f	Allowed Protocol Mapper Types	MAG	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	MAG	anonymous
8a8f46fd-61d7-4d30-830e-264c2fa4dd51	Allowed Client Scopes	MAG	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	MAG	anonymous
656c891e-5ccb-4353-bf9b-a00ee88056d0	Allowed Protocol Mapper Types	MAG	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	MAG	authenticated
2d51c5b8-5627-4412-a8a0-75d1484deed2	Allowed Client Scopes	MAG	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	MAG	authenticated
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: -
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
7e2e6209-0c8a-4f4f-8162-ddeaed802c18	afece65e-a27f-407a-bcf2-f9a81a5d963c	kid	e8422df5-7cbc-4950-a162-03ed8a88802d
1f390565-7845-457a-aa4b-6acfdc2fa67d	afece65e-a27f-407a-bcf2-f9a81a5d963c	secret	hSk-JIlVZ3BZcui43F8K8w
1021218e-0e1a-49d4-869d-097ead18fac9	afece65e-a27f-407a-bcf2-f9a81a5d963c	priority	100
ce98fdd0-696c-4b98-8401-4957d9b92b5e	81097085-6d41-4f59-abf1-0d0f7c359645	certificate	MIIClTCCAX0CBgF8fisjFDANBgkqhkiG9w0BAQsFADAOMQwwCgYDVQQDDANNQUcwHhcNMjExMDE0MDkzNzA4WhcNMzExMDE0MDkzODQ4WjAOMQwwCgYDVQQDDANNQUcwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDmoezt8MdmCZaARm4akhGr2x947aZhjZGgGgqkpGnJ5JLWZ9eD+vHU3SRwxWM2g2UAwubGUvjEw/cwda9y6Yiq3PLA+f0PNyLQN1oT0cEIhL2B9RIus0Yt3+nR09v9MAViHwhnHvQJ5u42hqBEMHHvhXbSecd3iLeBqafGEuED/k5Kl6gIYpEorTuK1nBbDrno1e05M7OhnmHYxey2fs/pYorQ9e7oJEN0nQXGowJH5QQYcvD0GYnukIz/ko9zEIsHPdn0tgAi/+Fadr3uWAKkJ6yCRX8Kxq45xpGIrKZ5yhfwKdMiZEp7j3ci953bc7vHFeIYm4FEuF7xP9XQCYAfAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAEiMRbcBtbErsB96EDqtwk7MQdss2mYD83nYymB428aWsUcv1HCAeRJkmh93T75rVMo/4d461ST97/oerXwzTkz+lGhP8C3dcRXo2mODa3b2UlyBl1BCyhctVG0XelTW91NjssHjc2HQV9ihVTJGLwAlhpePHOIp9Fny9HpY13MEW37PxbeLlKWyrJSe31aJ77RnjyT4+/BZFNGRUN7If+l48+zQ5BW6SRdlgK4MffKdJwwtf+7WcNOwbvegwjGPBSSrzAvMytv9PVAcLiwYSZtgLwrR2Enl2GDX8BqYp7rr13Ip3WxVx3QZz+WUQEs/dKD1SdYcGk7P2QslcXcKenI=
9b87ff14-4c0f-4efd-ab98-e5b376ba2042	81097085-6d41-4f59-abf1-0d0f7c359645	privateKey	MIIEowIBAAKCAQEA5qHs7fDHZgmWgEZuGpIRq9sfeO2mYY2RoBoKpKRpyeSS1mfXg/rx1N0kcMVjNoNlAMLmxlL4xMP3MHWvcumIqtzywPn9Dzci0DdaE9HBCIS9gfUSLrNGLd/p0dPb/TAFYh8IZx70CebuNoagRDBx74V20nnHd4i3gamnxhLhA/5OSpeoCGKRKK07itZwWw656NXtOTOzoZ5h2MXstn7P6WKK0PXu6CRDdJ0FxqMCR+UEGHLw9BmJ7pCM/5KPcxCLBz3Z9LYAIv/hWna97lgCpCesgkV/CsauOcaRiKymecoX8CnTImRKe493Ived23O7xxXiGJuBRLhe8T/V0AmAHwIDAQABAoIBAQDcFCSNIbiFLB0Lpyml/UETp3Ou58hfSsJt7qu9VI8GczGTm1/St4JRR/1gB1uXR2b4hQPGuKJe0UluWr7jfupFcbXMZEERZeG4ozk3tG7pfBGCk6OYIMaVPBhZfDturYZVjZttG+JwGIe0TF9e8oOmtsseKcsny7Sg7I4GuzkxnoiHuHMGJBRGc3R/ENHBjp1aKlbsLBvO7EFkp6jaarIBAXWfMfiHJCQGpbrhom5ko5zw612jeRuqbW1zT+oaJdRu2Xal1D6Y1AzITgrTRE0XxZ3aoIYA79QVWvMmUxUxmRqmhzUv6fKjXBFXNmb84YbkU/2gJAymXgry6fEBdGXhAoGBAPr5EruowmA5DEqqSacJvepwCxe5vTnZXyyvxNEaML3ZKZIX1SpHi3j/5HqBdHadhuasYkiVmt73u0HXXQl30ma8zPFFaA4ZkcYhikHaXnUI3mFE9LoDrm6kuiqSICs22Kg8TIkKycJAujayPDJcxkfHdPNFy/Jb7LTD0vxYiTpnAoGBAOtAjT0BToYerjuW+/JIsXZzfx/G0yk768wG4ntykcJW4PVhUugSlP7XapsCH+5+roFJBfrCh2pDmTFyYL67zUG4aNjFqNo3ZcgfZKx5bpXNLuzPNOow2WaOSB/cnH9Nl9xxso3ord4dUN91uBQqs37+i1ojcBo+GfwPZDywE2mJAoGABqy/KcyINuTthcLXqKCis2x9bwkalkJIvLiEBIesyi/PYjpOCgzTEcnEetmcjlcMMnBdQM7xyoJOMacXq1vLdb4JuVT+OnnFnb5gnfW/018EAxRBaf0VE45AAUfXoS6ZPog0BOULjqYIDdJZtYEwKNKOMrYlgXGebwRSRTHZnHsCgYBdZ7rsXulznRjmthMA5tX3RvJRhpruw0jjMFSaWSoAdIhLRUIqvL4F1TgRpa1R/2CAGqNSJgyoJ4DaviQlduGPV43hi9F4GwjBhZ1uUaSTu+0Gv1quJYkcDCAc7nYAoalLMKWJbLoj95XVs6LL9wxfvudLeciX0tJ0XxQYeHysqQKBgAkwtdljlLNaiL+Zo04aOQLkPCimpyKHD3yBq0j5XNojVZAA5WMVyQJl0xgX2UHoFV8xAPjDrQSy7dcT2M5hPLoOBGMeAiZkbRcGsM0cJvETiefKryai/7vlkOlDyav/VRAhNekekqHOCKfv2U8TpyLa1PBmSD/zS1hnQDlE0/wu
5b9597f2-d506-40e7-aa3f-abfbea4a5745	81097085-6d41-4f59-abf1-0d0f7c359645	priority	100
239b5ec7-6ba7-4c1c-af59-7eda0e7c3ea5	d02da4f3-e1ae-4499-9fb7-3b87effdfc6d	kid	a5c0ddcf-cb07-408a-8582-cc3b8f2aad76
fd15482b-8700-4f06-846b-2a80f54aa4a0	d02da4f3-e1ae-4499-9fb7-3b87effdfc6d	priority	100
ca004119-1081-4a41-9160-fb414e8d60cd	d02da4f3-e1ae-4499-9fb7-3b87effdfc6d	algorithm	HS256
1fcc7fff-e041-400f-85bd-e5c4e51a730b	d02da4f3-e1ae-4499-9fb7-3b87effdfc6d	secret	kPSz9Yfl9oIUZCccbPoh1bF5oX98Ssn9tYkwXM4OpI-jLDISiwU2lcYEaLLRhf9ZZddVJYNS2qQs7-Kn6XHDAg
1f6e012c-204d-445e-a5d2-9e9f4335b221	8a8f46fd-61d7-4d30-830e-264c2fa4dd51	allow-default-scopes	true
7da02c35-5079-484a-bcad-eb8728553e74	24ad13ce-359b-4b12-a2c5-0f3749f995e3	max-clients	200
47f2c7be-2fd0-4f27-a99e-62894190099b	656c891e-5ccb-4353-bf9b-a00ee88056d0	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
56e09c52-7184-4632-a083-4c86ab9a36bf	656c891e-5ccb-4353-bf9b-a00ee88056d0	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
e0f4434b-f4a0-47fd-acfa-3ad4f0da1211	656c891e-5ccb-4353-bf9b-a00ee88056d0	allowed-protocol-mapper-types	saml-role-list-mapper
b1c0aed7-7b0a-486e-92eb-d3f6e3e0106a	656c891e-5ccb-4353-bf9b-a00ee88056d0	allowed-protocol-mapper-types	oidc-address-mapper
d833f377-8cb3-4362-aa9d-e56a8e3d4da9	656c891e-5ccb-4353-bf9b-a00ee88056d0	allowed-protocol-mapper-types	saml-user-attribute-mapper
663ee36a-a003-4d52-b1bd-0f897a0090c8	656c891e-5ccb-4353-bf9b-a00ee88056d0	allowed-protocol-mapper-types	oidc-full-name-mapper
7010d3c8-2f90-4e0f-971f-7160c42c77e2	656c891e-5ccb-4353-bf9b-a00ee88056d0	allowed-protocol-mapper-types	saml-user-property-mapper
7350cfd9-ae3c-423d-b834-2206430c537d	656c891e-5ccb-4353-bf9b-a00ee88056d0	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
08ca6d23-6557-4202-8d15-a2c744699a33	27629b00-7708-44c4-a23b-87004e319759	host-sending-registration-request-must-match	true
64cb0bb2-74e7-4079-939f-ebf4602f2483	27629b00-7708-44c4-a23b-87004e319759	client-uris-must-match	true
413d3caf-2876-44b3-91e2-b670ecf58e91	e6cba7a8-9e08-48ff-b512-e55270fe383f	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
8ad1b18c-3462-4814-8f4f-6737f8020328	e6cba7a8-9e08-48ff-b512-e55270fe383f	allowed-protocol-mapper-types	oidc-address-mapper
398687d5-8d8e-4d08-a03a-4fe94f31c32d	e6cba7a8-9e08-48ff-b512-e55270fe383f	allowed-protocol-mapper-types	saml-user-attribute-mapper
d26d8bb9-abe4-4bbc-9f9e-0ef09055f82a	e6cba7a8-9e08-48ff-b512-e55270fe383f	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
04c11d1e-25db-4bcd-9454-488b2e3acf22	e6cba7a8-9e08-48ff-b512-e55270fe383f	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
e0037896-6dfb-4cf6-bab6-523c39cb7090	e6cba7a8-9e08-48ff-b512-e55270fe383f	allowed-protocol-mapper-types	saml-role-list-mapper
32100401-0ba6-4464-b20c-9d569c28d641	e6cba7a8-9e08-48ff-b512-e55270fe383f	allowed-protocol-mapper-types	oidc-full-name-mapper
c249b3b5-eb03-4c79-be8c-a2d461d63444	e6cba7a8-9e08-48ff-b512-e55270fe383f	allowed-protocol-mapper-types	saml-user-property-mapper
3c011a88-a270-4282-95fb-5c2cdf914d0b	2d51c5b8-5627-4412-a8a0-75d1484deed2	allow-default-scopes	true
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: -
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
017a5b0c-2639-4149-9f37-9452dc8ff121	2774b58f-9215-4d9f-99a9-c1b9b5a20191
017a5b0c-2639-4149-9f37-9452dc8ff121	b8aaa89c-5c11-4093-b042-ae2f32fa7667
017a5b0c-2639-4149-9f37-9452dc8ff121	6862f43d-5789-406f-b94c-ed21db17cb6f
017a5b0c-2639-4149-9f37-9452dc8ff121	39b7c3c2-46c1-4cac-b79c-d460592fb33c
017a5b0c-2639-4149-9f37-9452dc8ff121	7ec023c5-9e42-4325-ac39-62824b51098e
017a5b0c-2639-4149-9f37-9452dc8ff121	91b55080-2941-473c-ab57-76cb7ab8f2c2
017a5b0c-2639-4149-9f37-9452dc8ff121	f49d95c1-b01e-4b6b-8473-3d69fb390403
017a5b0c-2639-4149-9f37-9452dc8ff121	5824a6bc-f393-41d0-8bb3-73ed0c68d2a8
017a5b0c-2639-4149-9f37-9452dc8ff121	c1aed4c7-8690-4f32-a197-0edcce6248d8
017a5b0c-2639-4149-9f37-9452dc8ff121	bb888ec0-a881-45a5-a9ab-9af4bab32b33
017a5b0c-2639-4149-9f37-9452dc8ff121	987968ad-e031-40be-883f-d6f377790d2f
017a5b0c-2639-4149-9f37-9452dc8ff121	8436bfbb-7cc2-41a2-bb62-67dc116b819e
017a5b0c-2639-4149-9f37-9452dc8ff121	a733065f-c5a0-4e6e-ab0b-177abf2c5da8
017a5b0c-2639-4149-9f37-9452dc8ff121	9d2986e6-b8cf-48ed-9102-5efb6361af60
017a5b0c-2639-4149-9f37-9452dc8ff121	85f4ec04-0479-4c7a-941a-9d0023493d4b
017a5b0c-2639-4149-9f37-9452dc8ff121	a0d5c684-0f0a-4c2e-ab17-ee1d23f2f8ac
017a5b0c-2639-4149-9f37-9452dc8ff121	2d88c3d6-4c5b-4418-b348-cb6f187f882c
39b7c3c2-46c1-4cac-b79c-d460592fb33c	85f4ec04-0479-4c7a-941a-9d0023493d4b
6862f43d-5789-406f-b94c-ed21db17cb6f	9d2986e6-b8cf-48ed-9102-5efb6361af60
6862f43d-5789-406f-b94c-ed21db17cb6f	2d88c3d6-4c5b-4418-b348-cb6f187f882c
8c7bebbb-5060-40b1-95d3-fd4219296dd9	8e70c551-ae07-46d2-84a4-a295447c2869
8c7bebbb-5060-40b1-95d3-fd4219296dd9	35153be4-77dd-4ce1-b779-f6218e2b3a89
8c7bebbb-5060-40b1-95d3-fd4219296dd9	d234085f-4360-4df2-881e-d28730a1d47a
8c7bebbb-5060-40b1-95d3-fd4219296dd9	05c89a52-239d-45ba-b644-491bc6a97b10
8c7bebbb-5060-40b1-95d3-fd4219296dd9	eb7fc4c4-6f74-4539-a929-d6df8ece2ca6
8c7bebbb-5060-40b1-95d3-fd4219296dd9	b73c1b8a-4755-47f0-af12-8c917fffeda7
8c7bebbb-5060-40b1-95d3-fd4219296dd9	7863bc9a-df8c-4ee6-ad55-28ce5fd734ba
8c7bebbb-5060-40b1-95d3-fd4219296dd9	b4e94c7e-2bfa-436c-b967-1e0060018b60
8c7bebbb-5060-40b1-95d3-fd4219296dd9	28f37dc9-4a17-489f-8a58-b998b5791583
8c7bebbb-5060-40b1-95d3-fd4219296dd9	a7ab5d31-0388-46ca-9ac0-30002f493981
8c7bebbb-5060-40b1-95d3-fd4219296dd9	ad7221e6-5a5e-48ec-9695-6d4299afdfc7
8c7bebbb-5060-40b1-95d3-fd4219296dd9	3213f038-f1e6-46a7-a719-2bd956751c0d
8c7bebbb-5060-40b1-95d3-fd4219296dd9	fa453334-d981-4997-9815-390e2564a8b5
8c7bebbb-5060-40b1-95d3-fd4219296dd9	5db7a446-8b92-4d12-b928-42b387220c63
8c7bebbb-5060-40b1-95d3-fd4219296dd9	83c9992d-55a4-4588-8cfb-8349167a6d7e
8c7bebbb-5060-40b1-95d3-fd4219296dd9	c8081ddd-a50b-460c-ae4e-aa93b043594a
8c7bebbb-5060-40b1-95d3-fd4219296dd9	96fcc8f8-c9fc-4fb5-96ec-4207aacad947
05c89a52-239d-45ba-b644-491bc6a97b10	83c9992d-55a4-4588-8cfb-8349167a6d7e
d234085f-4360-4df2-881e-d28730a1d47a	96fcc8f8-c9fc-4fb5-96ec-4207aacad947
d234085f-4360-4df2-881e-d28730a1d47a	5db7a446-8b92-4d12-b928-42b387220c63
64c8f33d-3a88-47d5-ae85-e7709b3c92bf	f2b7512e-6080-41be-ad38-46292cb9061e
64c8f33d-3a88-47d5-ae85-e7709b3c92bf	ace9a4e6-d3d9-4c51-8c24-2ec63a4d1f52
ace9a4e6-d3d9-4c51-8c24-2ec63a4d1f52	8f504e9b-11d3-4744-b255-ce11f249e9e2
aa5e4901-3930-4788-8886-6b5af219084b	1e953e82-93ba-403e-be31-42a37faec734
017a5b0c-2639-4149-9f37-9452dc8ff121	014a367e-57c3-46a5-9a15-a720252e9e36
8c7bebbb-5060-40b1-95d3-fd4219296dd9	44f9a8ab-add5-4a9d-985a-db30e70fa3cf
64c8f33d-3a88-47d5-ae85-e7709b3c92bf	008360b3-9666-404c-a2ad-788147654cac
64c8f33d-3a88-47d5-ae85-e7709b3c92bf	5305ce79-6358-4391-99b7-9cd6a06429a4
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
6409d537-2299-4090-af4a-4ad3c92187b6	\N	password	97f3b26f-a6ee-44c9-b682-b86d0be2667e	1634204294377	\N	{"value":"EXv8qLUf0HuEnqe8LC2+XqmmJMx9UB11/EbAbDT6G0rE7nGjyqIFPbuRNkZUN6dVmiyDAy8nVTm87tfyxGiCxw==","salt":"cjwuvK1mQbwb69QeIfSLxg==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
f3b70ff9-0582-4680-aee6-353279094f9a	\N	password	7862f557-1660-44f8-8596-bb9b6517848c	1634207032572	\N	{"value":"5pHzSyfh9LQkRBB+2r1MMwim7j15tG2u0kkzmXK0O7oNx4WJpZdo+8gRlwJtm1YUlWipwtrwWhRyQxj9ssRptg==","salt":"v/f4KkvekuQYaz1D1ikwpQ==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
06e3575a-739d-4c67-84ab-0ae73091bae3	\N	password	cd81ac3c-2cf4-4eae-a8d7-92134c2ee573	1636034420172	\N	{"value":"WHWtDSE1bnr93fCKFL28abpfJbYaBl6fGDKhL1l8ypYzysdhixed7GHO3KVaVg5HeFYDVF0+/2VgEQcLHJl3qQ==","salt":"mF2bJa5IAc3FeV3SA6Q1OQ==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
e6aa3765-e2d4-4ffd-abf1-0f09b5a72c4d	\N	password	39032731-308a-40be-92d8-c67f957422fb	1636034470278	\N	{"value":"aLkmZb8+aaO9XI2ZJ9j6OK035N7LDNfAJKfEA9ay5LPBLRb4lMe2ncXkhAM01wGcwsPX0EoZXSIx/8gn/UxMBQ==","salt":"2Zvq4C0D0HHF3Ilv0uwYxA==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
f15bc4a9-3eb5-48b2-a50d-7d2ae3bfcebc	\N	password	56544d30-bb5b-4071-9b7a-bb41e5b564b7	1636034543336	\N	{"value":"0xputhGlA0DN0RtL0bMfcHWEo8LCYZLGbRwCuvwYaK3J9ztNzd5RKt/AaUl0E5LbyWZ2XNInfCQuMlicQRVeIg==","salt":"+QGYm5OISkN1xGx++Tb+ow==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
166c7796-264b-4dc0-ba78-b4bf1652cc29	\N	password	1767b4c5-90ff-4365-a2f9-c811bb4788b9	1636034596272	\N	{"value":"RnCNa4NHpwJXVO8ejNMJW1qHkVYIVCOHAawEkdo9LqiNI2ls7p5YmskwN8kinaX5AC3kRPdSFaseI0H85uunFg==","salt":"9UfSZDJjmlXJ61HeU3pLlA==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
c1b59e6f-dc55-42c4-984b-beb8462a963c	\N	password	61f434f7-7198-45b0-8f83-5457d84756fb	1636034637827	\N	{"value":"K5JYHinDaoW/pWr50zJO2yGoeDkRTLG5yusvH3X2/VLfJdrPJTVWVrF4q/PwDLS+vRrnXbTkBw3WkzDMCD3qFA==","salt":"0S8OUEqGWyxLg4a2Xa8HKA==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
bcfce620-c5e7-40fb-b8dd-9ad3e26d7e4e	\N	password	db231577-4404-4e0e-a5c2-9a332293b307	1636034696610	\N	{"value":"qHulsT6flOlvMGsraWfqihv/n3EXy9Ra1aR1IwVYl1tUYSCcjlK/cj2ZDXo/9cEb7CgWEtMBUKWLXY/qEeXQnQ==","salt":"O3itRr5Hf/xblUiD0xk23Q==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: -
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
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
1001	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: -
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
MAG	c15c5363-490a-48d2-9edf-b12d8669b7cf	f
MAG	fc4ba834-d258-4deb-9b04-5dac5518559a	t
MAG	13ac6628-4572-4335-a50c-2761c21c3cc0	t
MAG	0fb0feeb-c8d3-4a65-889d-fd69ce493eab	t
MAG	4cf73263-9888-43d5-af5b-fc70ea4b99be	f
MAG	72d38159-ce38-477d-b26a-695d1be288d8	f
MAG	708c7fd8-1731-4cf9-8ea2-5b3bb57d65d6	t
MAG	323bbbd8-2c6c-4080-a351-7f4cf8fd42b2	t
MAG	bcca4bf3-80df-4c1c-9394-36b7263928b8	f
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
7d2d0cd4-0850-4e0c-9fe8-436ae5acd0c0	1f46f199-ece2-4aa5-b727-d20254c88f88
eb76f94b-8773-4fef-bf76-e5af4241f81e	1f46f199-ece2-4aa5-b727-d20254c88f88
46c5fd97-de04-4794-9f2a-9cfea1bd7d4e	1f46f199-ece2-4aa5-b727-d20254c88f88
d4163a3f-27c1-41fe-a175-aaa72ed9e7bd	1f46f199-ece2-4aa5-b727-d20254c88f88
aecda267-e5d2-4b52-8e40-625e6c71af79	1f46f199-ece2-4aa5-b727-d20254c88f88
2545a564-9065-44ee-914f-2f1f96b65ce2	1f46f199-ece2-4aa5-b727-d20254c88f88
1a432c43-df8c-42b2-853a-ef192c787ba8	1f46f199-ece2-4aa5-b727-d20254c88f88
5841f1a2-79e0-4dee-9967-062f8b2f97e6	1f46f199-ece2-4aa5-b727-d20254c88f88
45f3cd34-556f-43be-8fb6-4a292d4e3acf	1f46f199-ece2-4aa5-b727-d20254c88f88
cf914889-0d42-4ab0-a78a-a884b1346a13	1f46f199-ece2-4aa5-b727-d20254c88f88
40ffee6f-5fa2-480d-b5e9-59be22fbf2ce	1f46f199-ece2-4aa5-b727-d20254c88f88
779787a1-d6a8-4879-909e-2e79bbccc18f	1f46f199-ece2-4aa5-b727-d20254c88f88
3c5bce67-533a-4b11-8096-fa4306953b07	1f46f199-ece2-4aa5-b727-d20254c88f88
e321ff6b-4ee8-4fd9-8762-6de90c3e12e0	1f46f199-ece2-4aa5-b727-d20254c88f88
fb15a7ac-007f-4d74-a0c3-104fc3eaff09	1f46f199-ece2-4aa5-b727-d20254c88f88
64c8f33d-3a88-47d5-ae85-e7709b3c92bf	1f46f199-ece2-4aa5-b727-d20254c88f88
2ef52a77-cab7-43cb-80c8-be4015be464f	1f46f199-ece2-4aa5-b727-d20254c88f88
fc023f7d-664d-4073-87c0-3e012f1410d6	1f46f199-ece2-4aa5-b727-d20254c88f88
1c3f039e-1799-462c-95c7-d4f87ddc9f66	1f46f199-ece2-4aa5-b727-d20254c88f88
009ec49a-cd54-4c73-9375-8c90c1e1d935	1f46f199-ece2-4aa5-b727-d20254c88f88
1c781121-5301-4835-ac2a-0bc9bdc2e68b	1f46f199-ece2-4aa5-b727-d20254c88f88
3bbc0458-e438-496a-ae70-0de5ddad7aab	1f46f199-ece2-4aa5-b727-d20254c88f88
ff0e886d-1fdc-4d49-8e63-8fad858ea7c7	1f46f199-ece2-4aa5-b727-d20254c88f88
674aae9f-4ba7-4810-988b-a37cd0410dc9	1f46f199-ece2-4aa5-b727-d20254c88f88
ef725bbd-4b99-4dec-add0-2777d5be9f75	1f46f199-ece2-4aa5-b727-d20254c88f88
fc750a92-46c6-4703-949a-49e303b2d351	1f46f199-ece2-4aa5-b727-d20254c88f88
4a58764b-0e0c-47ef-87d0-42662f897705	1f46f199-ece2-4aa5-b727-d20254c88f88
f2c24d8c-a3cc-4ee0-8220-11c7c6f41c92	1f46f199-ece2-4aa5-b727-d20254c88f88
67c4bd3a-ac7b-487a-962c-e0bce9fb561e	1f46f199-ece2-4aa5-b727-d20254c88f88
3db76cdb-6fcd-4f11-8fb8-2614f7d2fe40	1f46f199-ece2-4aa5-b727-d20254c88f88
d5a2b0cd-f8ba-4462-bbcf-5456ba376b09	1f46f199-ece2-4aa5-b727-d20254c88f88
4e85b527-4bc3-44e6-83e0-73bfa0d4a5c5	1f46f199-ece2-4aa5-b727-d20254c88f88
925d0b82-544f-4e4f-8cbf-d01083cc5b24	1f46f199-ece2-4aa5-b727-d20254c88f88
23e10dd2-76ae-4b31-baa6-64db0d205d35	1f46f199-ece2-4aa5-b727-d20254c88f88
13e8d1dd-283a-4294-a06a-736b9672aecc	1f46f199-ece2-4aa5-b727-d20254c88f88
bcd9dc03-3487-4adb-931b-c1dd6139ef07	1f46f199-ece2-4aa5-b727-d20254c88f88
f539450c-cc0a-4552-b8dc-053a1afa59b3	1f46f199-ece2-4aa5-b727-d20254c88f88
34611b0c-3d43-43c2-a830-c7119d8d83e6	1f46f199-ece2-4aa5-b727-d20254c88f88
8f37c28a-765e-487f-86d7-9160a279064a	1f46f199-ece2-4aa5-b727-d20254c88f88
bde03be2-dc36-4ab7-b3f0-87860e001803	1f46f199-ece2-4aa5-b727-d20254c88f88
e8e5d386-6aa7-48f8-bd7e-e34de93e1fa0	1f46f199-ece2-4aa5-b727-d20254c88f88
b427d730-c56c-4683-94e8-94480afae181	1f46f199-ece2-4aa5-b727-d20254c88f88
87e8076f-755c-49bf-a21e-109a51b7ecef	1f46f199-ece2-4aa5-b727-d20254c88f88
f88cd8fb-deb3-4bab-a201-6189837fe2c7	1f46f199-ece2-4aa5-b727-d20254c88f88
615b6948-6a59-4467-98e9-485a403ec31f	1f46f199-ece2-4aa5-b727-d20254c88f88
52b153c8-2f79-4062-8e1a-92aed8747349	1f46f199-ece2-4aa5-b727-d20254c88f88
80159323-703d-4796-857c-846eeafe21ab	1f46f199-ece2-4aa5-b727-d20254c88f88
c443952a-09bb-43f2-ba97-2f2a36f585dd	1f46f199-ece2-4aa5-b727-d20254c88f88
0c22f5d1-39f5-455a-9e51-f6371dde6c13	1f46f199-ece2-4aa5-b727-d20254c88f88
0b15e52b-fd82-4f11-a07f-9b223c897667	1f46f199-ece2-4aa5-b727-d20254c88f88
f63b70a9-a6a3-4ca9-81fc-8a393578a942	1f46f199-ece2-4aa5-b727-d20254c88f88
a19f0824-340c-469d-a382-a691dec9b518	1f46f199-ece2-4aa5-b727-d20254c88f88
78cf6dfa-7a9a-4e8a-81e8-656fee68226c	1f46f199-ece2-4aa5-b727-d20254c88f88
ec749e4a-cf71-4e22-9439-a6f057df28e4	1f46f199-ece2-4aa5-b727-d20254c88f88
5f3ea567-c9bd-4917-9184-a2bb480e99c9	1f46f199-ece2-4aa5-b727-d20254c88f88
3f07b1db-b430-47df-a317-5ad7cddb4657	1f46f199-ece2-4aa5-b727-d20254c88f88
c3ec7b2b-52b8-4cfa-aeef-32dae037da04	1f46f199-ece2-4aa5-b727-d20254c88f88
5210774f-0a1d-487a-8f9e-ce3b2a557ca1	1f46f199-ece2-4aa5-b727-d20254c88f88
d5c38e60-8fc8-4156-b5c5-cdc926567071	1f46f199-ece2-4aa5-b727-d20254c88f88
2a1501c6-6a87-4f5d-a1fc-3d5017f9dfc6	1f46f199-ece2-4aa5-b727-d20254c88f88
18feff2e-1da5-4210-ba72-1b5f15daa9b3	1f46f199-ece2-4aa5-b727-d20254c88f88
bd40f431-fe8a-4180-9730-7c1e8d80c0ad	1f46f199-ece2-4aa5-b727-d20254c88f88
9425a30d-75a4-49da-b4b4-f8e829a98c1d	1f46f199-ece2-4aa5-b727-d20254c88f88
d7f3eda6-3145-477d-a73d-c4774fd8e9f5	1f46f199-ece2-4aa5-b727-d20254c88f88
42d36968-984a-4e4d-9de5-aa1bb0943aa8	1f46f199-ece2-4aa5-b727-d20254c88f88
2e1a2e7b-e0c3-4638-861e-f3eebf6a92b6	1f46f199-ece2-4aa5-b727-d20254c88f88
2a639ee0-4906-4242-a3ea-ec283e19f151	1f46f199-ece2-4aa5-b727-d20254c88f88
59bf53b4-6c1c-4b0c-ae46-4115268f8127	1f46f199-ece2-4aa5-b727-d20254c88f88
5b940a8e-b663-4722-970d-3579511c0168	1f46f199-ece2-4aa5-b727-d20254c88f88
dce6894a-5b86-4338-87fa-93dfebe07dc8	1f46f199-ece2-4aa5-b727-d20254c88f88
b7f922c9-9edc-41bf-bd56-3e66425de0ad	1f46f199-ece2-4aa5-b727-d20254c88f88
f88cd8fb-deb3-4bab-a201-6189837fe2c7	1b5c0d65-8666-4805-b046-d2adbac999d3
615b6948-6a59-4467-98e9-485a403ec31f	1b5c0d65-8666-4805-b046-d2adbac999d3
52b153c8-2f79-4062-8e1a-92aed8747349	1b5c0d65-8666-4805-b046-d2adbac999d3
f539450c-cc0a-4552-b8dc-053a1afa59b3	1b5c0d65-8666-4805-b046-d2adbac999d3
a19f0824-340c-469d-a382-a691dec9b518	1b5c0d65-8666-4805-b046-d2adbac999d3
34611b0c-3d43-43c2-a830-c7119d8d83e6	1b5c0d65-8666-4805-b046-d2adbac999d3
d5a2b0cd-f8ba-4462-bbcf-5456ba376b09	1b5c0d65-8666-4805-b046-d2adbac999d3
23e10dd2-76ae-4b31-baa6-64db0d205d35	1b5c0d65-8666-4805-b046-d2adbac999d3
0b15e52b-fd82-4f11-a07f-9b223c897667	1b5c0d65-8666-4805-b046-d2adbac999d3
925d0b82-544f-4e4f-8cbf-d01083cc5b24	1b5c0d65-8666-4805-b046-d2adbac999d3
bcd9dc03-3487-4adb-931b-c1dd6139ef07	1b5c0d65-8666-4805-b046-d2adbac999d3
8f37c28a-765e-487f-86d7-9160a279064a	1b5c0d65-8666-4805-b046-d2adbac999d3
bde03be2-dc36-4ab7-b3f0-87860e001803	1b5c0d65-8666-4805-b046-d2adbac999d3
e8e5d386-6aa7-48f8-bd7e-e34de93e1fa0	1b5c0d65-8666-4805-b046-d2adbac999d3
78cf6dfa-7a9a-4e8a-81e8-656fee68226c	1b5c0d65-8666-4805-b046-d2adbac999d3
b427d730-c56c-4683-94e8-94480afae181	1b5c0d65-8666-4805-b046-d2adbac999d3
ec749e4a-cf71-4e22-9439-a6f057df28e4	1b5c0d65-8666-4805-b046-d2adbac999d3
87e8076f-755c-49bf-a21e-109a51b7ecef	1b5c0d65-8666-4805-b046-d2adbac999d3
5f3ea567-c9bd-4917-9184-a2bb480e99c9	1b5c0d65-8666-4805-b046-d2adbac999d3
67c4bd3a-ac7b-487a-962c-e0bce9fb561e	1b5c0d65-8666-4805-b046-d2adbac999d3
3db76cdb-6fcd-4f11-8fb8-2614f7d2fe40	1b5c0d65-8666-4805-b046-d2adbac999d3
80159323-703d-4796-857c-846eeafe21ab	1b5c0d65-8666-4805-b046-d2adbac999d3
3f07b1db-b430-47df-a317-5ad7cddb4657	1b5c0d65-8666-4805-b046-d2adbac999d3
0c22f5d1-39f5-455a-9e51-f6371dde6c13	1b5c0d65-8666-4805-b046-d2adbac999d3
5210774f-0a1d-487a-8f9e-ce3b2a557ca1	1b5c0d65-8666-4805-b046-d2adbac999d3
779787a1-d6a8-4879-909e-2e79bbccc18f	950afbf7-d362-4cbf-b3b4-d516f31e9c06
59bf53b4-6c1c-4b0c-ae46-4115268f8127	950afbf7-d362-4cbf-b3b4-d516f31e9c06
ef725bbd-4b99-4dec-add0-2777d5be9f75	950afbf7-d362-4cbf-b3b4-d516f31e9c06
1a432c43-df8c-42b2-853a-ef192c787ba8	950afbf7-d362-4cbf-b3b4-d516f31e9c06
5841f1a2-79e0-4dee-9967-062f8b2f97e6	950afbf7-d362-4cbf-b3b4-d516f31e9c06
9425a30d-75a4-49da-b4b4-f8e829a98c1d	950afbf7-d362-4cbf-b3b4-d516f31e9c06
d7f3eda6-3145-477d-a73d-c4774fd8e9f5	950afbf7-d362-4cbf-b3b4-d516f31e9c06
009ec49a-cd54-4c73-9375-8c90c1e1d935	950afbf7-d362-4cbf-b3b4-d516f31e9c06
1c781121-5301-4835-ac2a-0bc9bdc2e68b	950afbf7-d362-4cbf-b3b4-d516f31e9c06
aecda267-e5d2-4b52-8e40-625e6c71af79	6b31c531-1f16-47f0-910f-f2444b897626
7d2d0cd4-0850-4e0c-9fe8-436ae5acd0c0	6b31c531-1f16-47f0-910f-f2444b897626
eb76f94b-8773-4fef-bf76-e5af4241f81e	6b31c531-1f16-47f0-910f-f2444b897626
18feff2e-1da5-4210-ba72-1b5f15daa9b3	6b31c531-1f16-47f0-910f-f2444b897626
13e8d1dd-283a-4294-a06a-736b9672aecc	6b31c531-1f16-47f0-910f-f2444b897626
bcd9dc03-3487-4adb-931b-c1dd6139ef07	6b31c531-1f16-47f0-910f-f2444b897626
f63b70a9-a6a3-4ca9-81fc-8a393578a942	6b31c531-1f16-47f0-910f-f2444b897626
2545a564-9065-44ee-914f-2f1f96b65ce2	6b31c531-1f16-47f0-910f-f2444b897626
bd40f431-fe8a-4180-9730-7c1e8d80c0ad	6b31c531-1f16-47f0-910f-f2444b897626
1c3f039e-1799-462c-95c7-d4f87ddc9f66	6b31c531-1f16-47f0-910f-f2444b897626
45f3cd34-556f-43be-8fb6-4a292d4e3acf	6b31c531-1f16-47f0-910f-f2444b897626
46c5fd97-de04-4794-9f2a-9cfea1bd7d4e	6b31c531-1f16-47f0-910f-f2444b897626
42d36968-984a-4e4d-9de5-aa1bb0943aa8	6b31c531-1f16-47f0-910f-f2444b897626
3bbc0458-e438-496a-ae70-0de5ddad7aab	6b31c531-1f16-47f0-910f-f2444b897626
d5c38e60-8fc8-4156-b5c5-cdc926567071	6b31c531-1f16-47f0-910f-f2444b897626
c443952a-09bb-43f2-ba97-2f2a36f585dd	6b31c531-1f16-47f0-910f-f2444b897626
c3ec7b2b-52b8-4cfa-aeef-32dae037da04	6b31c531-1f16-47f0-910f-f2444b897626
c443952a-09bb-43f2-ba97-2f2a36f585dd	eedf0c9d-4d86-463a-9823-a121df0e0030
c3ec7b2b-52b8-4cfa-aeef-32dae037da04	eedf0c9d-4d86-463a-9823-a121df0e0030
c443952a-09bb-43f2-ba97-2f2a36f585dd	83a5aa3e-cb59-498a-a6c1-0ec4881e05ed
c3ec7b2b-52b8-4cfa-aeef-32dae037da04	83a5aa3e-cb59-498a-a6c1-0ec4881e05ed
c3ec7b2b-52b8-4cfa-aeef-32dae037da04	4328acf2-3727-4c4a-ab55-e52a6dd53754
dce6894a-5b86-4338-87fa-93dfebe07dc8	4328acf2-3727-4c4a-ab55-e52a6dd53754
c3ec7b2b-52b8-4cfa-aeef-32dae037da04	f7553629-b634-46dd-93b1-2c6d427e5938
dce6894a-5b86-4338-87fa-93dfebe07dc8	f7553629-b634-46dd-93b1-2c6d427e5938
a080e3fd-50fb-49ad-8b4a-127da21f52a1	1f46f199-ece2-4aa5-b727-d20254c88f88
a080e3fd-50fb-49ad-8b4a-127da21f52a1	6b31c531-1f16-47f0-910f-f2444b897626
42190bba-086b-4d27-a207-844ac7469b09	1f46f199-ece2-4aa5-b727-d20254c88f88
42190bba-086b-4d27-a207-844ac7469b09	6b31c531-1f16-47f0-910f-f2444b897626
9f83302a-a68e-4bfc-b7be-041df3b0c512	1f46f199-ece2-4aa5-b727-d20254c88f88
8af94f3c-a28f-4e20-8fd3-c764f4583486	1f46f199-ece2-4aa5-b727-d20254c88f88
cc644095-267c-4522-b300-51148d803ef9	1f46f199-ece2-4aa5-b727-d20254c88f88
e0136624-1023-4951-8828-fbf480525750	1f46f199-ece2-4aa5-b727-d20254c88f88
3fc905f5-a2d8-4537-b2ba-cf9db4f42b8c	1f46f199-ece2-4aa5-b727-d20254c88f88
9f83302a-a68e-4bfc-b7be-041df3b0c512	4328acf2-3727-4c4a-ab55-e52a6dd53754
cc644095-267c-4522-b300-51148d803ef9	4328acf2-3727-4c4a-ab55-e52a6dd53754
e0136624-1023-4951-8828-fbf480525750	4328acf2-3727-4c4a-ab55-e52a6dd53754
3fc905f5-a2d8-4537-b2ba-cf9db4f42b8c	4328acf2-3727-4c4a-ab55-e52a6dd53754
8af94f3c-a28f-4e20-8fd3-c764f4583486	4328acf2-3727-4c4a-ab55-e52a6dd53754
28b3c9ac-5051-450e-b145-4a60adfbf8db	eedf0c9d-4d86-463a-9823-a121df0e0030
28b3c9ac-5051-450e-b145-4a60adfbf8db	950afbf7-d362-4cbf-b3b4-d516f31e9c06
28b3c9ac-5051-450e-b145-4a60adfbf8db	6b31c531-1f16-47f0-910f-f2444b897626
28b3c9ac-5051-450e-b145-4a60adfbf8db	4328acf2-3727-4c4a-ab55-e52a6dd53754
d0e0b2e9-dd58-4c2d-8a03-0cc9c0b49e40	1b5c0d65-8666-4805-b046-d2adbac999d3
3eb3cae9-78cc-40e4-8b2b-5f02f898d124	950afbf7-d362-4cbf-b3b4-d516f31e9c06
d0e0b2e9-dd58-4c2d-8a03-0cc9c0b49e40	950afbf7-d362-4cbf-b3b4-d516f31e9c06
28b3c9ac-5051-450e-b145-4a60adfbf8db	1f46f199-ece2-4aa5-b727-d20254c88f88
28b3c9ac-5051-450e-b145-4a60adfbf8db	83a5aa3e-cb59-498a-a6c1-0ec4881e05ed
28b3c9ac-5051-450e-b145-4a60adfbf8db	f7553629-b634-46dd-93b1-2c6d427e5938
28b3c9ac-5051-450e-b145-4a60adfbf8db	1b5c0d65-8666-4805-b046-d2adbac999d3
6ceb9245-34e9-47db-846c-84ce41ccd773	1f46f199-ece2-4aa5-b727-d20254c88f88
ba7ce0b8-c0ff-43ef-9204-ea707a733946	1f46f199-ece2-4aa5-b727-d20254c88f88
3eb3cae9-78cc-40e4-8b2b-5f02f898d124	1f46f199-ece2-4aa5-b727-d20254c88f88
d0e0b2e9-dd58-4c2d-8a03-0cc9c0b49e40	1f46f199-ece2-4aa5-b727-d20254c88f88
188eb6ed-f834-4809-a650-4b195010c52d	1f46f199-ece2-4aa5-b727-d20254c88f88
3eb3cae9-78cc-40e4-8b2b-5f02f898d124	1b5c0d65-8666-4805-b046-d2adbac999d3
3eb3cae9-78cc-40e4-8b2b-5f02f898d124	f7553629-b634-46dd-93b1-2c6d427e5938
d0e0b2e9-dd58-4c2d-8a03-0cc9c0b49e40	f7553629-b634-46dd-93b1-2c6d427e5938
812158c7-3893-4940-a93f-eb51ea651ddc	1f46f199-ece2-4aa5-b727-d20254c88f88
4211c814-bf74-4947-8419-fed9785bc61c	1f46f199-ece2-4aa5-b727-d20254c88f88
d936759e-ed53-403a-b868-3fee690727db	1f46f199-ece2-4aa5-b727-d20254c88f88
52348cc2-556c-4796-ad1b-97fbdb8a0a3d	1f46f199-ece2-4aa5-b727-d20254c88f88
ae961da8-0407-4e73-9d08-784b3e715507	1f46f199-ece2-4aa5-b727-d20254c88f88
ff1673ff-f36c-4cac-8330-332fd8dc91df	1f46f199-ece2-4aa5-b727-d20254c88f88
081f713a-0b65-4594-b168-b269c083de91	1f46f199-ece2-4aa5-b727-d20254c88f88
ef81d059-abe9-4b53-8aec-11e6c07dd77b	1f46f199-ece2-4aa5-b727-d20254c88f88
9fdf00d5-923c-4807-8e76-bcbe619daa49	1f46f199-ece2-4aa5-b727-d20254c88f88
ef81d059-abe9-4b53-8aec-11e6c07dd77b	83a5aa3e-cb59-498a-a6c1-0ec4881e05ed
9fdf00d5-923c-4807-8e76-bcbe619daa49	83a5aa3e-cb59-498a-a6c1-0ec4881e05ed
081f713a-0b65-4594-b168-b269c083de91	4328acf2-3727-4c4a-ab55-e52a6dd53754
ee7ad2f7-cbad-4b5a-afd0-b52429b99280	1f46f199-ece2-4aa5-b727-d20254c88f88
096da306-c0a6-4ba6-8242-986827a6d322	1f46f199-ece2-4aa5-b727-d20254c88f88
539319ee-bb8b-4034-b640-7a9b52d42652	1f46f199-ece2-4aa5-b727-d20254c88f88
adb45550-7bfb-43b1-baf2-81bcce48e2e1	1f46f199-ece2-4aa5-b727-d20254c88f88
8fbce741-f54b-44f8-b01f-ccb88c659a3e	1f46f199-ece2-4aa5-b727-d20254c88f88
8e0f29c0-b814-4593-8165-f2eabc38baff	1f46f199-ece2-4aa5-b727-d20254c88f88
5b8b6f88-9db0-480d-b6d5-3bfb9eb5bbd6	1f46f199-ece2-4aa5-b727-d20254c88f88
fa2dde3f-9c85-483c-85ac-9d43cc4fb14a	1f46f199-ece2-4aa5-b727-d20254c88f88
d7003411-b99c-4d4c-a0b0-d1853524dbfc	1f46f199-ece2-4aa5-b727-d20254c88f88
b880619e-3465-4c5b-ac81-b96e6938b827	1f46f199-ece2-4aa5-b727-d20254c88f88
539319ee-bb8b-4034-b640-7a9b52d42652	4328acf2-3727-4c4a-ab55-e52a6dd53754
fa2dde3f-9c85-483c-85ac-9d43cc4fb14a	4328acf2-3727-4c4a-ab55-e52a6dd53754
adb45550-7bfb-43b1-baf2-81bcce48e2e1	4328acf2-3727-4c4a-ab55-e52a6dd53754
d7003411-b99c-4d4c-a0b0-d1853524dbfc	4328acf2-3727-4c4a-ab55-e52a6dd53754
98568e72-cd82-4e69-827c-d08ae9ccd614	1f46f199-ece2-4aa5-b727-d20254c88f88
7a4ffeca-c8eb-42f9-b20e-233fdf3babc1	1f46f199-ece2-4aa5-b727-d20254c88f88
00c1bd6d-bd4a-4670-bc7a-ea209e968d0f	1f46f199-ece2-4aa5-b727-d20254c88f88
96854908-12a5-44eb-ac78-9c9ca7c667ed	1f46f199-ece2-4aa5-b727-d20254c88f88
50ea9015-3a49-415d-bcb0-40a43b0d621d	1f46f199-ece2-4aa5-b727-d20254c88f88
98568e72-cd82-4e69-827c-d08ae9ccd614	eedf0c9d-4d86-463a-9823-a121df0e0030
98568e72-cd82-4e69-827c-d08ae9ccd614	83a5aa3e-cb59-498a-a6c1-0ec4881e05ed
98568e72-cd82-4e69-827c-d08ae9ccd614	f7553629-b634-46dd-93b1-2c6d427e5938
57a32cb9-ce24-4bb4-a0b8-b779eba8747e	1f46f199-ece2-4aa5-b727-d20254c88f88
d2b6e8cf-b6f7-434a-912e-e0f83ada677c	1f46f199-ece2-4aa5-b727-d20254c88f88
c1fc71f9-31aa-4cd0-a84b-1c165fc28b5f	1f46f199-ece2-4aa5-b727-d20254c88f88
c77c2676-512e-4900-91eb-067fd79095d0	1f46f199-ece2-4aa5-b727-d20254c88f88
22b191cf-d7b0-4236-a96c-133372c2f63b	1f46f199-ece2-4aa5-b727-d20254c88f88
29d25727-5f5a-4d98-8ced-1e28623d3afc	1f46f199-ece2-4aa5-b727-d20254c88f88
a10dce7e-17b2-4038-aebb-0a3a4d81be3a	1f46f199-ece2-4aa5-b727-d20254c88f88
244ac39f-d362-4440-b13f-b32687378a96	1f46f199-ece2-4aa5-b727-d20254c88f88
4129fa43-087c-4a2b-98cd-647c131637fd	1f46f199-ece2-4aa5-b727-d20254c88f88
730d1b13-d2be-478b-856c-aadabe3716c9	1f46f199-ece2-4aa5-b727-d20254c88f88
2dbd3d31-3a7b-403d-80c5-b4a3f8d20bad	1f46f199-ece2-4aa5-b727-d20254c88f88
8bb8f126-44cf-4263-9579-96554da1b99a	1f46f199-ece2-4aa5-b727-d20254c88f88
a492a758-206b-45d8-ac61-7dd93fdd4d6a	1f46f199-ece2-4aa5-b727-d20254c88f88
43cdb9e5-d93d-40b3-8e1d-ccd8ac4a36fe	1f46f199-ece2-4aa5-b727-d20254c88f88
783d6816-451f-49b8-827b-b2f6aae11407	1f46f199-ece2-4aa5-b727-d20254c88f88
f854fcc5-b82c-4cd0-80bb-3aa32cf703b0	1f46f199-ece2-4aa5-b727-d20254c88f88
56dd65f4-7aa7-4041-a6ed-d25fa1096c51	1f46f199-ece2-4aa5-b727-d20254c88f88
2d855ce5-6c69-4f58-9e1c-cb69f89c015d	1f46f199-ece2-4aa5-b727-d20254c88f88
24076705-3ec9-476a-8eac-2fb9a006217c	1f46f199-ece2-4aa5-b727-d20254c88f88
aa37dc51-b193-40fe-af2a-b92e35e0df85	1f46f199-ece2-4aa5-b727-d20254c88f88
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
1b5c0d65-8666-4805-b046-d2adbac999d3	REGISTERED_USER	 	MAG
83a5aa3e-cb59-498a-a6c1-0ec4881e05ed	MAJOR_LEAD	 	MAG
1f46f199-ece2-4aa5-b727-d20254c88f88	ADMIN	 	MAG
950afbf7-d362-4cbf-b3b4-d516f31e9c06	PORTAL_EDITOR	 	MAG
6b31c531-1f16-47f0-910f-f2444b897626	COMPANY_ADMIN	 	MAG
eedf0c9d-4d86-463a-9823-a121df0e0030	COMPANY_CONTACT_PERSON	 	MAG
4328acf2-3727-4c4a-ab55-e52a6dd53754	STUDENT	 	MAG
f7553629-b634-46dd-93b1-2c6d427e5938	STUDY_DEPARTMENT	 	MAG
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: -
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
64c8f33d-3a88-47d5-ae85-e7709b3c92bf	MAG	f	${role_default-roles}	default-roles-mag	MAG	\N	\N
2774b58f-9215-4d9f-99a9-c1b9b5a20191	5f12ca42-1560-4c3a-bd42-ac550e7d341c	t	${role_create-client}	create-client	master	5f12ca42-1560-4c3a-bd42-ac550e7d341c	\N
b8aaa89c-5c11-4093-b042-ae2f32fa7667	5f12ca42-1560-4c3a-bd42-ac550e7d341c	t	${role_view-realm}	view-realm	master	5f12ca42-1560-4c3a-bd42-ac550e7d341c	\N
6862f43d-5789-406f-b94c-ed21db17cb6f	5f12ca42-1560-4c3a-bd42-ac550e7d341c	t	${role_view-users}	view-users	master	5f12ca42-1560-4c3a-bd42-ac550e7d341c	\N
39b7c3c2-46c1-4cac-b79c-d460592fb33c	5f12ca42-1560-4c3a-bd42-ac550e7d341c	t	${role_view-clients}	view-clients	master	5f12ca42-1560-4c3a-bd42-ac550e7d341c	\N
7ec023c5-9e42-4325-ac39-62824b51098e	5f12ca42-1560-4c3a-bd42-ac550e7d341c	t	${role_view-events}	view-events	master	5f12ca42-1560-4c3a-bd42-ac550e7d341c	\N
91b55080-2941-473c-ab57-76cb7ab8f2c2	5f12ca42-1560-4c3a-bd42-ac550e7d341c	t	${role_view-identity-providers}	view-identity-providers	master	5f12ca42-1560-4c3a-bd42-ac550e7d341c	\N
f49d95c1-b01e-4b6b-8473-3d69fb390403	5f12ca42-1560-4c3a-bd42-ac550e7d341c	t	${role_view-authorization}	view-authorization	master	5f12ca42-1560-4c3a-bd42-ac550e7d341c	\N
5824a6bc-f393-41d0-8bb3-73ed0c68d2a8	5f12ca42-1560-4c3a-bd42-ac550e7d341c	t	${role_manage-realm}	manage-realm	master	5f12ca42-1560-4c3a-bd42-ac550e7d341c	\N
c1aed4c7-8690-4f32-a197-0edcce6248d8	5f12ca42-1560-4c3a-bd42-ac550e7d341c	t	${role_manage-users}	manage-users	master	5f12ca42-1560-4c3a-bd42-ac550e7d341c	\N
bb888ec0-a881-45a5-a9ab-9af4bab32b33	5f12ca42-1560-4c3a-bd42-ac550e7d341c	t	${role_manage-clients}	manage-clients	master	5f12ca42-1560-4c3a-bd42-ac550e7d341c	\N
987968ad-e031-40be-883f-d6f377790d2f	5f12ca42-1560-4c3a-bd42-ac550e7d341c	t	${role_manage-events}	manage-events	master	5f12ca42-1560-4c3a-bd42-ac550e7d341c	\N
8436bfbb-7cc2-41a2-bb62-67dc116b819e	5f12ca42-1560-4c3a-bd42-ac550e7d341c	t	${role_manage-identity-providers}	manage-identity-providers	master	5f12ca42-1560-4c3a-bd42-ac550e7d341c	\N
a733065f-c5a0-4e6e-ab0b-177abf2c5da8	5f12ca42-1560-4c3a-bd42-ac550e7d341c	t	${role_manage-authorization}	manage-authorization	master	5f12ca42-1560-4c3a-bd42-ac550e7d341c	\N
9d2986e6-b8cf-48ed-9102-5efb6361af60	5f12ca42-1560-4c3a-bd42-ac550e7d341c	t	${role_query-users}	query-users	master	5f12ca42-1560-4c3a-bd42-ac550e7d341c	\N
85f4ec04-0479-4c7a-941a-9d0023493d4b	5f12ca42-1560-4c3a-bd42-ac550e7d341c	t	${role_query-clients}	query-clients	master	5f12ca42-1560-4c3a-bd42-ac550e7d341c	\N
a0d5c684-0f0a-4c2e-ab17-ee1d23f2f8ac	5f12ca42-1560-4c3a-bd42-ac550e7d341c	t	${role_query-realms}	query-realms	master	5f12ca42-1560-4c3a-bd42-ac550e7d341c	\N
2d88c3d6-4c5b-4418-b348-cb6f187f882c	5f12ca42-1560-4c3a-bd42-ac550e7d341c	t	${role_query-groups}	query-groups	master	5f12ca42-1560-4c3a-bd42-ac550e7d341c	\N
d5a2b0cd-f8ba-4462-bbcf-5456ba376b09	MAG	f	\N	GET_ADDRESS_BY_ID	MAG	\N	\N
0b15e52b-fd82-4f11-a07f-9b223c897667	MAG	f	\N	GET_COMPANY_BY_ID	MAG	\N	\N
ec749e4a-cf71-4e22-9439-a6f057df28e4	MAG	f	\N	GET_MAJOR_BY_ID	MAG	\N	\N
3f07b1db-b430-47df-a317-5ad7cddb4657	MAG	f	\N	GET_SEMESTER_BY_ID	MAG	\N	\N
c3ec7b2b-52b8-4cfa-aeef-32dae037da04	MAG	f	\N	GET_STUDENT_BY_ID	MAG	\N	\N
5210774f-0a1d-487a-8f9e-ce3b2a557ca1	MAG	f	\N	GET_TRAINING_LOCATION_BY_ID	MAG	\N	\N
8c7bebbb-5060-40b1-95d3-fd4219296dd9	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	t	${role_realm-admin}	realm-admin	MAG	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	\N
8e70c551-ae07-46d2-84a4-a295447c2869	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	t	${role_create-client}	create-client	MAG	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	\N
35153be4-77dd-4ce1-b779-f6218e2b3a89	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	t	${role_view-realm}	view-realm	MAG	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	\N
d234085f-4360-4df2-881e-d28730a1d47a	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	t	${role_view-users}	view-users	MAG	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	\N
05c89a52-239d-45ba-b644-491bc6a97b10	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	t	${role_view-clients}	view-clients	MAG	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	\N
eb7fc4c4-6f74-4539-a929-d6df8ece2ca6	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	t	${role_view-events}	view-events	MAG	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	\N
b73c1b8a-4755-47f0-af12-8c917fffeda7	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	t	${role_view-identity-providers}	view-identity-providers	MAG	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	\N
7863bc9a-df8c-4ee6-ad55-28ce5fd734ba	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	t	${role_view-authorization}	view-authorization	MAG	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	\N
b4e94c7e-2bfa-436c-b967-1e0060018b60	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	t	${role_manage-realm}	manage-realm	MAG	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	\N
28f37dc9-4a17-489f-8a58-b998b5791583	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	t	${role_manage-users}	manage-users	MAG	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	\N
a7ab5d31-0388-46ca-9ac0-30002f493981	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	t	${role_manage-clients}	manage-clients	MAG	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	\N
ad7221e6-5a5e-48ec-9695-6d4299afdfc7	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	t	${role_manage-events}	manage-events	MAG	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	\N
3213f038-f1e6-46a7-a719-2bd956751c0d	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	t	${role_manage-identity-providers}	manage-identity-providers	MAG	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	\N
fa453334-d981-4997-9815-390e2564a8b5	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	t	${role_manage-authorization}	manage-authorization	MAG	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	\N
5db7a446-8b92-4d12-b928-42b387220c63	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	t	${role_query-users}	query-users	MAG	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	\N
83c9992d-55a4-4588-8cfb-8349167a6d7e	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	t	${role_query-clients}	query-clients	MAG	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	\N
c8081ddd-a50b-460c-ae4e-aa93b043594a	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	t	${role_query-realms}	query-realms	MAG	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	\N
96fcc8f8-c9fc-4fb5-96ec-4207aacad947	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	t	${role_query-groups}	query-groups	MAG	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	\N
f2b7512e-6080-41be-ad38-46292cb9061e	006df867-19d0-4bbc-9de7-f01ca96aaf7a	t	${role_view-profile}	view-profile	MAG	006df867-19d0-4bbc-9de7-f01ca96aaf7a	\N
ace9a4e6-d3d9-4c51-8c24-2ec63a4d1f52	006df867-19d0-4bbc-9de7-f01ca96aaf7a	t	${role_manage-account}	manage-account	MAG	006df867-19d0-4bbc-9de7-f01ca96aaf7a	\N
8f504e9b-11d3-4744-b255-ce11f249e9e2	006df867-19d0-4bbc-9de7-f01ca96aaf7a	t	${role_manage-account-links}	manage-account-links	MAG	006df867-19d0-4bbc-9de7-f01ca96aaf7a	\N
e20dae00-71af-4cb7-866c-9be1bda08605	006df867-19d0-4bbc-9de7-f01ca96aaf7a	t	${role_view-applications}	view-applications	MAG	006df867-19d0-4bbc-9de7-f01ca96aaf7a	\N
f63b70a9-a6a3-4ca9-81fc-8a393578a942	MAG	f	\N	GET_CONTACT_PERSON_BY_ID	MAG	\N	\N
78cf6dfa-7a9a-4e8a-81e8-656fee68226c	MAG	f	\N	GET_INTERNSHIP_BY_ID	MAG	\N	\N
5f3ea567-c9bd-4917-9184-a2bb480e99c9	MAG	f	\N	GET_MAJOR_LEADER_BY_ID	MAG	\N	\N
1e953e82-93ba-403e-be31-42a37faec734	006df867-19d0-4bbc-9de7-f01ca96aaf7a	t	${role_view-consent}	view-consent	MAG	006df867-19d0-4bbc-9de7-f01ca96aaf7a	\N
aa5e4901-3930-4788-8886-6b5af219084b	006df867-19d0-4bbc-9de7-f01ca96aaf7a	t	${role_manage-consent}	manage-consent	MAG	006df867-19d0-4bbc-9de7-f01ca96aaf7a	\N
1587302c-2a32-4269-a44b-be9365f53141	006df867-19d0-4bbc-9de7-f01ca96aaf7a	t	${role_delete-account}	delete-account	MAG	006df867-19d0-4bbc-9de7-f01ca96aaf7a	\N
014a367e-57c3-46a5-9a15-a720252e9e36	5f12ca42-1560-4c3a-bd42-ac550e7d341c	t	${role_impersonation}	impersonation	master	5f12ca42-1560-4c3a-bd42-ac550e7d341c	\N
44f9a8ab-add5-4a9d-985a-db30e70fa3cf	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	t	${role_impersonation}	impersonation	MAG	57d0ab0d-d25b-4b1d-91ee-1ed79754e651	\N
0a1943d6-84ed-4f32-9ecd-72068b5f67ea	dcfd7631-d53e-4bce-b337-40ec363a561e	t	${role_read-token}	read-token	MAG	dcfd7631-d53e-4bce-b337-40ec363a561e	\N
008360b3-9666-404c-a2ad-788147654cac	MAG	f	${role_offline-access}	offline_access	MAG	\N	\N
5305ce79-6358-4391-99b7-9cd6a06429a4	MAG	f	${role_uma_authorization}	uma_authorization	MAG	\N	\N
87e8076f-755c-49bf-a21e-109a51b7ecef	MAG	f	\N	GET_ALL_MAJOR_LEADER	MAG	\N	\N
40ffee6f-5fa2-480d-b5e9-59be22fbf2ce	MAG	f	\N	CREATE_MAJOR_LEADER	MAG	\N	\N
2a639ee0-4906-4242-a3ea-ec283e19f151	MAG	f	\N	UPDATE_MAJOR_LEADER	MAG	\N	\N
674aae9f-4ba7-4810-988b-a37cd0410dc9	MAG	f	\N	DELETE_MAJOR_LEADER	MAG	\N	\N
67c4bd3a-ac7b-487a-962c-e0bce9fb561e	MAG	f	\N	FIND_ALL_MAJOR_LEADER_BY_MAJOR_ID	MAG	\N	\N
3db76cdb-6fcd-4f11-8fb8-2614f7d2fe40	MAG	f	\N	FIND_ALL_MAJOR_LEADER_BY_USER_ID	MAG	\N	\N
b427d730-c56c-4683-94e8-94480afae181	MAG	f	\N	GET_ALL_MAJOR	MAG	\N	\N
cf914889-0d42-4ab0-a78a-a884b1346a13	MAG	f	\N	CREATE_MAJOR	MAG	\N	\N
2e1a2e7b-e0c3-4638-861e-f3eebf6a92b6	MAG	f	\N	UPDATE_MAJOR	MAG	\N	\N
ff0e886d-1fdc-4d49-8e63-8fad858ea7c7	MAG	f	\N	DELETE_MAJOR	MAG	\N	\N
4e85b527-4bc3-44e6-83e0-73bfa0d4a5c5	MAG	f	\N	GET_ALL_ADDRESS	MAG	\N	\N
d4163a3f-27c1-41fe-a175-aaa72ed9e7bd	MAG	f	\N	CREATE_ADDRESS	MAG	\N	\N
2a1501c6-6a87-4f5d-a1fc-3d5017f9dfc6	MAG	f	\N	UPDATE_ADDRESS	MAG	\N	\N
2ef52a77-cab7-43cb-80c8-be4015be464f	MAG	f	\N	DELETE_ADDRESS	MAG	\N	\N
23e10dd2-76ae-4b31-baa6-64db0d205d35	MAG	f	\N	GET_ALL_COMPANY	MAG	\N	\N
925d0b82-544f-4e4f-8cbf-d01083cc5b24	MAG	f	\N	GET_ALL_ADDRESS_BY_COMPANY	MAG	\N	\N
bcd9dc03-3487-4adb-931b-c1dd6139ef07	MAG	f	\N	GET_ALL_CONTACT_PERSON_BY_COMPANY	MAG	\N	\N
aecda267-e5d2-4b52-8e40-625e6c71af79	MAG	f	\N	CREATE_COMPANY	MAG	\N	\N
7d2d0cd4-0850-4e0c-9fe8-436ae5acd0c0	MAG	f	\N	ASSIGN_ADDRESS_TO_COMPANY	MAG	\N	\N
eb76f94b-8773-4fef-bf76-e5af4241f81e	MAG	f	\N	ASSIGN_CONTACT_PERSON_TO_COMPANY	MAG	\N	\N
18feff2e-1da5-4210-ba72-1b5f15daa9b3	MAG	f	\N	UPDATE_COMPANY	MAG	\N	\N
fc023f7d-664d-4073-87c0-3e012f1410d6	MAG	f	\N	DELETE_COMPANY	MAG	\N	\N
13e8d1dd-283a-4294-a06a-736b9672aecc	MAG	f	\N	GET_ALL_CONTACT_PERSON	MAG	\N	\N
2545a564-9065-44ee-914f-2f1f96b65ce2	MAG	f	\N	CREATE_CONTACT_PERSON	MAG	\N	\N
bd40f431-fe8a-4180-9730-7c1e8d80c0ad	MAG	f	\N	UPDATE_CONTACT_PERSON	MAG	\N	\N
1c3f039e-1799-462c-95c7-d4f87ddc9f66	MAG	f	\N	DELETE_CONTACT_PERSON	MAG	\N	\N
8f37c28a-765e-487f-86d7-9160a279064a	MAG	f	\N	GET_ALL_INTERNSHIP	MAG	\N	\N
bde03be2-dc36-4ab7-b3f0-87860e001803	MAG	f	\N	GET_ALL_INTERNSHIP_BY_COMPANY	MAG	\N	\N
e8e5d386-6aa7-48f8-bd7e-e34de93e1fa0	MAG	f	\N	GET_ALL_INTERNSHIP_BY_SEMESTER	MAG	\N	\N
45f3cd34-556f-43be-8fb6-4a292d4e3acf	MAG	f	\N	CREATE_INTERNSHIP	MAG	\N	\N
46c5fd97-de04-4794-9f2a-9cfea1bd7d4e	MAG	f	\N	ASSIGN_STUDENT_TO_INTERNSHIP	MAG	\N	\N
42d36968-984a-4e4d-9de5-aa1bb0943aa8	MAG	f	\N	UPDATE_INTERNSHIP	MAG	\N	\N
3bbc0458-e438-496a-ae70-0de5ddad7aab	MAG	f	\N	DELETE_INTERNSHIP	MAG	\N	\N
d5c38e60-8fc8-4156-b5c5-cdc926567071	MAG	f	\N	REMOVE_ASSIGNED_STUDENT_FROM_INTERNSHIP	MAG	\N	\N
80159323-703d-4796-857c-846eeafe21ab	MAG	f	\N	GET_ALL_SEMESTER	MAG	\N	\N
3c5bce67-533a-4b11-8096-fa4306953b07	MAG	f	\N	CREATE_SEMESTER	MAG	\N	\N
5b940a8e-b663-4722-970d-3579511c0168	MAG	f	\N	UPDATE_SEMESTER	MAG	\N	\N
fc750a92-46c6-4703-949a-49e303b2d351	MAG	f	\N	DELETE_SEMESTER	MAG	\N	\N
c443952a-09bb-43f2-ba97-2f2a36f585dd	MAG	f	\N	GET_ALL_STUDENT	MAG	\N	\N
e321ff6b-4ee8-4fd9-8762-6de90c3e12e0	MAG	f	\N	CREATE_STUDENT	MAG	\N	\N
dce6894a-5b86-4338-87fa-93dfebe07dc8	MAG	f	\N	UPDATE_STUDENT	MAG	\N	\N
4a58764b-0e0c-47ef-87d0-42662f897705	MAG	f	\N	DELETE_STUDENT	MAG	\N	\N
0c22f5d1-39f5-455a-9e51-f6371dde6c13	MAG	f	\N	GET_ALL_TRAINING_LOCATION	MAG	\N	\N
fb15a7ac-007f-4d74-a0c3-104fc3eaff09	MAG	f	\N	CREATE_TRAINING_LOCATION	MAG	\N	\N
b7f922c9-9edc-41bf-bd56-3e66425de0ad	MAG	f	\N	UPDATE_TRAINING_LOCATION	MAG	\N	\N
f2c24d8c-a3cc-4ee0-8220-11c7c6f41c92	MAG	f	\N	DELETE_TRAINING_LOCATION	MAG	\N	\N
f539450c-cc0a-4552-b8dc-053a1afa59b3	MAG	f	\N	GET_ALL_CONTENT	MAG	\N	\N
1a432c43-df8c-42b2-853a-ef192c787ba8	MAG	f	\N	CREATE_CONTENT	MAG	\N	\N
9425a30d-75a4-49da-b4b4-f8e829a98c1d	MAG	f	\N	UPDATE_CONTENT	MAG	\N	\N
009ec49a-cd54-4c73-9375-8c90c1e1d935	MAG	f	\N	DELETE_CONTENT	MAG	\N	\N
34611b0c-3d43-43c2-a830-c7119d8d83e6	MAG	f	\N	GET_ALL_CONTENT_DOCUMENT	MAG	\N	\N
5841f1a2-79e0-4dee-9967-062f8b2f97e6	MAG	f	\N	CREATE_CONTENT_DOCUMENT	MAG	\N	\N
d7f3eda6-3145-477d-a73d-c4774fd8e9f5	MAG	f	\N	UPDATE_CONTENT_DOCUMENT	MAG	\N	\N
1c781121-5301-4835-ac2a-0bc9bdc2e68b	MAG	f	\N	DELETE_CONTENT_DOCUMENT	MAG	\N	\N
f88cd8fb-deb3-4bab-a201-6189837fe2c7	MAG	f	\N	GET_ALL_MENU	MAG	\N	\N
52b153c8-2f79-4062-8e1a-92aed8747349	MAG	f	\N	GET_ALL_MENU_BY_PARENT_ID	MAG	\N	\N
615b6948-6a59-4467-98e9-485a403ec31f	MAG	f	\N	GET_ALL_MENU_BY_MENU_TYPE	MAG	\N	\N
779787a1-d6a8-4879-909e-2e79bbccc18f	MAG	f	\N	CREATE_MENU	MAG	\N	\N
59bf53b4-6c1c-4b0c-ae46-4115268f8127	MAG	f	\N	UPDATE_MENU	MAG	\N	\N
ef725bbd-4b99-4dec-add0-2777d5be9f75	MAG	f	\N	DELETE_MENU	MAG	\N	\N
a19f0824-340c-469d-a382-a691dec9b518	MAG	f	\N	GET_CONTENT_BY_ID	MAG	\N	\N
a080e3fd-50fb-49ad-8b4a-127da21f52a1	MAG	f	\N	REMOVE_ADDRESS_FROM_COMPANY	MAG	\N	\N
42190bba-086b-4d27-a207-844ac7469b09	MAG	f	\N	REMOVE_CONTACT_PERSON_FROM_COMPANY	MAG	\N	\N
9f83302a-a68e-4bfc-b7be-041df3b0c512	MAG	f	\N	ASSIGN_ADDRESS_TO_STUDENT	MAG	\N	\N
cc644095-267c-4522-b300-51148d803ef9	MAG	f	\N	REMOVE_ADDRESS_FROM_STUDENT	MAG	\N	\N
3fc905f5-a2d8-4537-b2ba-cf9db4f42b8c	MAG	f	\N	UPLOAD_CV	MAG	\N	\N
e0136624-1023-4951-8828-fbf480525750	MAG	f	\N	UPDATE_CV	MAG	\N	\N
8af94f3c-a28f-4e20-8fd3-c764f4583486	MAG	f	\N	DELETE_CV	MAG	\N	\N
28b3c9ac-5051-450e-b145-4a60adfbf8db	MAG	f	\N	GET_ALL_SEMESTER_WITH_ACTIVE_REGISTRATION	MAG	\N	\N
3eb3cae9-78cc-40e4-8b2b-5f02f898d124	MAG	f	\N	GET_ALL_SEMESTER_DOCUMENT	MAG	\N	\N
d0e0b2e9-dd58-4c2d-8a03-0cc9c0b49e40	MAG	f	\N	GET_SEMESTER_DOCUMENT_BY_ID	MAG	\N	\N
6ceb9245-34e9-47db-846c-84ce41ccd773	MAG	f	\N	CREATE_SEMESTER_DOCUMENT	MAG	\N	\N
188eb6ed-f834-4809-a650-4b195010c52d	MAG	f	\N	UPDATE_SEMESTER_DOCUMENT	MAG	\N	\N
ba7ce0b8-c0ff-43ef-9204-ea707a733946	MAG	f	\N	DELETE_SEMESTER_DOCUMENT	MAG	\N	\N
d936759e-ed53-403a-b868-3fee690727db	MAG	f	\N	GET_ALL_CONFIGURATION	MAG	\N	\N
52348cc2-556c-4796-ad1b-97fbdb8a0a3d	MAG	f	\N	GET_CONFIGURATION_BY_ID	MAG	\N	\N
ae961da8-0407-4e73-9d08-784b3e715507	MAG	f	\N	GET_CONFIGURATION_BY_KEY	MAG	\N	\N
812158c7-3893-4940-a93f-eb51ea651ddc	MAG	f	\N	CREATE_CONFIGURATION	MAG	\N	\N
ff1673ff-f36c-4cac-8330-332fd8dc91df	MAG	f	\N	UPDATE_CONFIGURATION	MAG	\N	\N
4211c814-bf74-4947-8419-fed9785bc61c	MAG	f	\N	DELETE_CONFIGURATION	MAG	\N	\N
ef81d059-abe9-4b53-8aec-11e6c07dd77b	MAG	f	\N	GET_ALL_INTERNSHIP_FEEDBACK	MAG	\N	\N
9fdf00d5-923c-4807-8e76-bcbe619daa49	MAG	f	\N	GET_INTERNSHIP_FEEDBACK_BY_ID	MAG	\N	\N
081f713a-0b65-4594-b168-b269c083de91	MAG	f	\N	CREATE_INTERNSHIP_FEEDBACK	MAG	\N	\N
539319ee-bb8b-4034-b640-7a9b52d42652	MAG	f	\N	GET_ALL_INTERNSHIP_FEEDBACK_ANSWER	MAG	\N	\N
adb45550-7bfb-43b1-baf2-81bcce48e2e1	MAG	f	\N	GET_INTERNSHIP_FEEDBACK_ANSWER_BY_ID	MAG	\N	\N
ee7ad2f7-cbad-4b5a-afd0-b52429b99280	MAG	f	\N	CREATE_INTERNSHIP_FEEDBACK_ANSWER	MAG	\N	\N
8fbce741-f54b-44f8-b01f-ccb88c659a3e	MAG	f	\N	UPDATE_INTERNSHIP_FEEDBACK_ANSWER	MAG	\N	\N
096da306-c0a6-4ba6-8242-986827a6d322	MAG	f	\N	DELETE_INTERNSHIP_FEEDBACK_ANSWER	MAG	\N	\N
fa2dde3f-9c85-483c-85ac-9d43cc4fb14a	MAG	f	\N	GET_ALL_INTERNSHIP_FEEDBACK_QUESTION	MAG	\N	\N
d7003411-b99c-4d4c-a0b0-d1853524dbfc	MAG	f	\N	GET_INTERNSHIP_FEEDBACK_QUESTION_BY_ID	MAG	\N	\N
8e0f29c0-b814-4593-8165-f2eabc38baff	MAG	f	\N	CREATE_INTERNSHIP_FEEDBACK_QUESTION	MAG	\N	\N
b880619e-3465-4c5b-ac81-b96e6938b827	MAG	f	\N	UPDATE_INTERNSHIP_FEEDBACK_QUESTION	MAG	\N	\N
5b8b6f88-9db0-480d-b6d5-3bfb9eb5bbd6	MAG	f	\N	DELETE_INTERNSHIP_FEEDBACK_QUESTION	MAG	\N	\N
96854908-12a5-44eb-ac78-9c9ca7c667ed	MAG	f	\N	GET_MESSAGE_LOG_BY_ID	MAG	\N	\N
7a4ffeca-c8eb-42f9-b20e-233fdf3babc1	MAG	f	\N	DELETE_MESSAGE_LOG	MAG	\N	\N
43cdb9e5-d93d-40b3-8e1d-ccd8ac4a36fe	MAG	f	\N	GET_KEYCLOAK_GROUP_BY_GROUP_NAME	MAG	\N	\N
c77c2676-512e-4900-91eb-067fd79095d0	MAG	f	\N	CREATE_KEYCLOAK_ROLE	MAG	\N	\N
a492a758-206b-45d8-ac61-7dd93fdd4d6a	MAG	f	\N	GET_ALL_KEYCLOAK_USER	MAG	\N	\N
2d855ce5-6c69-4f58-9e1c-cb69f89c015d	MAG	f	\N	REMOVE_KEYCLOAK_GROUP_FROM_KEYCLOAK_USER	MAG	\N	\N
00c1bd6d-bd4a-4670-bc7a-ea209e968d0f	MAG	f	\N	GET_ALL_MESSAGE_LOG	MAG	\N	\N
c1fc71f9-31aa-4cd0-a84b-1c165fc28b5f	MAG	f	\N	CREATE_KEYCLOAK_GROUP	MAG	\N	\N
29d25727-5f5a-4d98-8ced-1e28623d3afc	MAG	f	\N	DELETE_KEYCLOAK_GROUP	MAG	\N	\N
d2b6e8cf-b6f7-434a-912e-e0f83ada677c	MAG	f	\N	ASSIGN_KEYCLOAK_ROLE_TO_KEYCLOAK_GROUP	MAG	\N	\N
24076705-3ec9-476a-8eac-2fb9a006217c	MAG	f	\N	REMOVE_KEYCLOAK_ROLE_FROM_KEYCLOAK_GROUP	MAG	\N	\N
f854fcc5-b82c-4cd0-80bb-3aa32cf703b0	MAG	f	\N	GET_KEYCLOAK_USER_BY_ID	MAG	\N	\N
56dd65f4-7aa7-4041-a6ed-d25fa1096c51	MAG	f	\N	GET_KEYCLOAK_USER_GROUPS_BY_USER_ID	MAG	\N	\N
244ac39f-d362-4440-b13f-b32687378a96	MAG	f	\N	DELETE_KEYCLOAK_USER	MAG	\N	\N
98568e72-cd82-4e69-827c-d08ae9ccd614	MAG	f	\N	CREATE_MESSAGE_LOG	MAG	\N	\N
50ea9015-3a49-415d-bcb0-40a43b0d621d	MAG	f	\N	UPDATE_MESSAGE_LOG	MAG	\N	\N
2dbd3d31-3a7b-403d-80c5-b4a3f8d20bad	MAG	f	\N	GET_ALL_KEYCLOAK_GROUP	MAG	\N	\N
8bb8f126-44cf-4263-9579-96554da1b99a	MAG	f	\N	GET_ALL_KEYCLOAK_ROLE	MAG	\N	\N
783d6816-451f-49b8-827b-b2f6aae11407	MAG	f	\N	GET_KEYCLOAK_ROLE_BY_ROLE_NAME	MAG	\N	\N
a10dce7e-17b2-4038-aebb-0a3a4d81be3a	MAG	f	\N	DELETE_KEYCLOAK_ROLE	MAG	\N	\N
22b191cf-d7b0-4236-a96c-133372c2f63b	MAG	f	\N	CREATE_KEYCLOAK_USER	MAG	\N	\N
aa37dc51-b193-40fe-af2a-b92e35e0df85	MAG	f	\N	UPDATE_KEYCLOAK_USER	MAG	\N	\N
57a32cb9-ce24-4bb4-a0b8-b779eba8747e	MAG	f	\N	ASSIGN_KEYCLOAK_GROUP_TO_KEYCLOAK_USER	MAG	\N	\N
730d1b13-d2be-478b-856c-aadabe3716c9	MAG	f	\N	ENABLE_KEYCLOAK_USER	MAG	\N	\N
4129fa43-087c-4a2b-98cd-647c131637fd	MAG	f	\N	DISABLE_KEYCLOAK_USER	MAG	\N	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.migration_model (id, version, update_time) FROM stdin;
cggaq	14.0.0	1634204293
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: -
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
38f5eed2-aa2d-4a2f-b7c7-e8269eeb7a91	audience resolve	openid-connect	oidc-audience-resolve-mapper	87ae7e2b-85a5-4f5c-a55b-4596d7dd3baa	\N
050f2ace-1fcc-42b3-a942-9a1ba5ed6d11	role list	saml	saml-role-list-mapper	\N	fc4ba834-d258-4deb-9b04-5dac5518559a
371d4dfb-e891-4435-869e-56b6ecc542f4	full name	openid-connect	oidc-full-name-mapper	\N	13ac6628-4572-4335-a50c-2761c21c3cc0
a234d74f-604f-47fa-8ab1-e972235702d6	family name	openid-connect	oidc-usermodel-property-mapper	\N	13ac6628-4572-4335-a50c-2761c21c3cc0
45297296-4c3c-46d6-8d7d-cb2878c2e292	given name	openid-connect	oidc-usermodel-property-mapper	\N	13ac6628-4572-4335-a50c-2761c21c3cc0
f89b4b98-b285-4670-870f-69f8c1496433	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	13ac6628-4572-4335-a50c-2761c21c3cc0
56490ba2-417d-438f-aab6-1e842786ed06	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	13ac6628-4572-4335-a50c-2761c21c3cc0
33a47c5c-4b32-4ad1-a3ac-4eb75e3a25c7	username	openid-connect	oidc-usermodel-property-mapper	\N	13ac6628-4572-4335-a50c-2761c21c3cc0
d81c7303-efc1-4117-9ca2-90d3b0d81c3d	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	13ac6628-4572-4335-a50c-2761c21c3cc0
2550810f-bbd9-4ac6-8acf-bc9a69b0c483	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	13ac6628-4572-4335-a50c-2761c21c3cc0
ad67e014-4df2-4cc5-a579-a6c2ff57c695	website	openid-connect	oidc-usermodel-attribute-mapper	\N	13ac6628-4572-4335-a50c-2761c21c3cc0
e4e4b815-68c1-4778-a229-339ed212955c	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	13ac6628-4572-4335-a50c-2761c21c3cc0
1a66fb91-d4eb-4827-8333-981cf0c5a1c8	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	13ac6628-4572-4335-a50c-2761c21c3cc0
106ee0a5-b51c-44cf-a9c1-bab516e0b02b	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	13ac6628-4572-4335-a50c-2761c21c3cc0
7309e370-dbe1-43ed-8957-314bb1da2f9b	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	13ac6628-4572-4335-a50c-2761c21c3cc0
040bc87b-2867-46c4-8b13-6a7747bc8760	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	13ac6628-4572-4335-a50c-2761c21c3cc0
57afcb06-5d17-47ed-b6a9-aab49fd75005	email	openid-connect	oidc-usermodel-property-mapper	\N	0fb0feeb-c8d3-4a65-889d-fd69ce493eab
c1611c95-8cbc-4425-9b4b-7c2d1d52d14d	email verified	openid-connect	oidc-usermodel-property-mapper	\N	0fb0feeb-c8d3-4a65-889d-fd69ce493eab
08444c68-5485-4a61-a765-1bb86e3b6269	address	openid-connect	oidc-address-mapper	\N	4cf73263-9888-43d5-af5b-fc70ea4b99be
b0acf7da-600a-4a47-9355-623f153b8327	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	72d38159-ce38-477d-b26a-695d1be288d8
a50fcab0-476e-48c8-ab40-79c64cfd88ca	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	72d38159-ce38-477d-b26a-695d1be288d8
7d445685-8192-467b-ada1-1fae0c55d63a	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	708c7fd8-1731-4cf9-8ea2-5b3bb57d65d6
a8f1f05f-e7ba-4cdd-898b-f345af3ebbf6	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	708c7fd8-1731-4cf9-8ea2-5b3bb57d65d6
18c49914-a10f-406b-b497-7970ca5483d5	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	708c7fd8-1731-4cf9-8ea2-5b3bb57d65d6
28af74ee-f99d-4305-b8ef-1b2c6f96dc0f	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	323bbbd8-2c6c-4080-a351-7f4cf8fd42b2
b57e9183-70bd-47b5-bbcc-f46d165054d0	upn	openid-connect	oidc-usermodel-property-mapper	\N	bcca4bf3-80df-4c1c-9394-36b7263928b8
2f7c9fd1-4fd0-4e33-b58c-c193a54a9478	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	bcca4bf3-80df-4c1c-9394-36b7263928b8
7b81f46f-a8f9-46c9-9e61-4e4ba4e12e32	locale	openid-connect	oidc-usermodel-attribute-mapper	f0f69f18-4c7f-4850-a6f3-8bc4b0189408	\N
3a1d6e13-865f-4851-90dd-ab9cbedff475	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	\N
68e44953-9083-488c-be5e-b1c41bcf7a73	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	\N
287858ff-d6bb-4eb9-895e-f9e8fbc61f39	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: -
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
050f2ace-1fcc-42b3-a942-9a1ba5ed6d11	false	single
050f2ace-1fcc-42b3-a942-9a1ba5ed6d11	Basic	attribute.nameformat
050f2ace-1fcc-42b3-a942-9a1ba5ed6d11	Role	attribute.name
371d4dfb-e891-4435-869e-56b6ecc542f4	true	userinfo.token.claim
371d4dfb-e891-4435-869e-56b6ecc542f4	true	id.token.claim
371d4dfb-e891-4435-869e-56b6ecc542f4	true	access.token.claim
a234d74f-604f-47fa-8ab1-e972235702d6	true	userinfo.token.claim
a234d74f-604f-47fa-8ab1-e972235702d6	lastName	user.attribute
a234d74f-604f-47fa-8ab1-e972235702d6	true	id.token.claim
a234d74f-604f-47fa-8ab1-e972235702d6	true	access.token.claim
a234d74f-604f-47fa-8ab1-e972235702d6	family_name	claim.name
a234d74f-604f-47fa-8ab1-e972235702d6	String	jsonType.label
45297296-4c3c-46d6-8d7d-cb2878c2e292	true	userinfo.token.claim
45297296-4c3c-46d6-8d7d-cb2878c2e292	firstName	user.attribute
45297296-4c3c-46d6-8d7d-cb2878c2e292	true	id.token.claim
45297296-4c3c-46d6-8d7d-cb2878c2e292	true	access.token.claim
45297296-4c3c-46d6-8d7d-cb2878c2e292	given_name	claim.name
45297296-4c3c-46d6-8d7d-cb2878c2e292	String	jsonType.label
f89b4b98-b285-4670-870f-69f8c1496433	true	userinfo.token.claim
f89b4b98-b285-4670-870f-69f8c1496433	middleName	user.attribute
f89b4b98-b285-4670-870f-69f8c1496433	true	id.token.claim
f89b4b98-b285-4670-870f-69f8c1496433	true	access.token.claim
f89b4b98-b285-4670-870f-69f8c1496433	middle_name	claim.name
f89b4b98-b285-4670-870f-69f8c1496433	String	jsonType.label
56490ba2-417d-438f-aab6-1e842786ed06	true	userinfo.token.claim
56490ba2-417d-438f-aab6-1e842786ed06	nickname	user.attribute
56490ba2-417d-438f-aab6-1e842786ed06	true	id.token.claim
56490ba2-417d-438f-aab6-1e842786ed06	true	access.token.claim
56490ba2-417d-438f-aab6-1e842786ed06	nickname	claim.name
56490ba2-417d-438f-aab6-1e842786ed06	String	jsonType.label
33a47c5c-4b32-4ad1-a3ac-4eb75e3a25c7	true	userinfo.token.claim
33a47c5c-4b32-4ad1-a3ac-4eb75e3a25c7	username	user.attribute
33a47c5c-4b32-4ad1-a3ac-4eb75e3a25c7	true	id.token.claim
33a47c5c-4b32-4ad1-a3ac-4eb75e3a25c7	true	access.token.claim
33a47c5c-4b32-4ad1-a3ac-4eb75e3a25c7	preferred_username	claim.name
33a47c5c-4b32-4ad1-a3ac-4eb75e3a25c7	String	jsonType.label
d81c7303-efc1-4117-9ca2-90d3b0d81c3d	true	userinfo.token.claim
d81c7303-efc1-4117-9ca2-90d3b0d81c3d	profile	user.attribute
d81c7303-efc1-4117-9ca2-90d3b0d81c3d	true	id.token.claim
d81c7303-efc1-4117-9ca2-90d3b0d81c3d	true	access.token.claim
d81c7303-efc1-4117-9ca2-90d3b0d81c3d	profile	claim.name
d81c7303-efc1-4117-9ca2-90d3b0d81c3d	String	jsonType.label
2550810f-bbd9-4ac6-8acf-bc9a69b0c483	true	userinfo.token.claim
2550810f-bbd9-4ac6-8acf-bc9a69b0c483	picture	user.attribute
2550810f-bbd9-4ac6-8acf-bc9a69b0c483	true	id.token.claim
2550810f-bbd9-4ac6-8acf-bc9a69b0c483	true	access.token.claim
2550810f-bbd9-4ac6-8acf-bc9a69b0c483	picture	claim.name
2550810f-bbd9-4ac6-8acf-bc9a69b0c483	String	jsonType.label
ad67e014-4df2-4cc5-a579-a6c2ff57c695	true	userinfo.token.claim
ad67e014-4df2-4cc5-a579-a6c2ff57c695	website	user.attribute
ad67e014-4df2-4cc5-a579-a6c2ff57c695	true	id.token.claim
ad67e014-4df2-4cc5-a579-a6c2ff57c695	true	access.token.claim
ad67e014-4df2-4cc5-a579-a6c2ff57c695	website	claim.name
ad67e014-4df2-4cc5-a579-a6c2ff57c695	String	jsonType.label
e4e4b815-68c1-4778-a229-339ed212955c	true	userinfo.token.claim
e4e4b815-68c1-4778-a229-339ed212955c	gender	user.attribute
e4e4b815-68c1-4778-a229-339ed212955c	true	id.token.claim
e4e4b815-68c1-4778-a229-339ed212955c	true	access.token.claim
e4e4b815-68c1-4778-a229-339ed212955c	gender	claim.name
e4e4b815-68c1-4778-a229-339ed212955c	String	jsonType.label
1a66fb91-d4eb-4827-8333-981cf0c5a1c8	true	userinfo.token.claim
1a66fb91-d4eb-4827-8333-981cf0c5a1c8	birthdate	user.attribute
1a66fb91-d4eb-4827-8333-981cf0c5a1c8	true	id.token.claim
1a66fb91-d4eb-4827-8333-981cf0c5a1c8	true	access.token.claim
1a66fb91-d4eb-4827-8333-981cf0c5a1c8	birthdate	claim.name
1a66fb91-d4eb-4827-8333-981cf0c5a1c8	String	jsonType.label
106ee0a5-b51c-44cf-a9c1-bab516e0b02b	true	userinfo.token.claim
106ee0a5-b51c-44cf-a9c1-bab516e0b02b	zoneinfo	user.attribute
106ee0a5-b51c-44cf-a9c1-bab516e0b02b	true	id.token.claim
106ee0a5-b51c-44cf-a9c1-bab516e0b02b	true	access.token.claim
106ee0a5-b51c-44cf-a9c1-bab516e0b02b	zoneinfo	claim.name
106ee0a5-b51c-44cf-a9c1-bab516e0b02b	String	jsonType.label
7309e370-dbe1-43ed-8957-314bb1da2f9b	true	userinfo.token.claim
7309e370-dbe1-43ed-8957-314bb1da2f9b	locale	user.attribute
7309e370-dbe1-43ed-8957-314bb1da2f9b	true	id.token.claim
7309e370-dbe1-43ed-8957-314bb1da2f9b	true	access.token.claim
7309e370-dbe1-43ed-8957-314bb1da2f9b	locale	claim.name
7309e370-dbe1-43ed-8957-314bb1da2f9b	String	jsonType.label
040bc87b-2867-46c4-8b13-6a7747bc8760	true	userinfo.token.claim
040bc87b-2867-46c4-8b13-6a7747bc8760	updatedAt	user.attribute
040bc87b-2867-46c4-8b13-6a7747bc8760	true	id.token.claim
040bc87b-2867-46c4-8b13-6a7747bc8760	true	access.token.claim
040bc87b-2867-46c4-8b13-6a7747bc8760	updated_at	claim.name
040bc87b-2867-46c4-8b13-6a7747bc8760	String	jsonType.label
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
08444c68-5485-4a61-a765-1bb86e3b6269	formatted	user.attribute.formatted
08444c68-5485-4a61-a765-1bb86e3b6269	country	user.attribute.country
08444c68-5485-4a61-a765-1bb86e3b6269	postal_code	user.attribute.postal_code
08444c68-5485-4a61-a765-1bb86e3b6269	true	userinfo.token.claim
08444c68-5485-4a61-a765-1bb86e3b6269	street	user.attribute.street
08444c68-5485-4a61-a765-1bb86e3b6269	true	id.token.claim
08444c68-5485-4a61-a765-1bb86e3b6269	region	user.attribute.region
08444c68-5485-4a61-a765-1bb86e3b6269	true	access.token.claim
08444c68-5485-4a61-a765-1bb86e3b6269	locality	user.attribute.locality
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
7d445685-8192-467b-ada1-1fae0c55d63a	true	multivalued
7d445685-8192-467b-ada1-1fae0c55d63a	foo	user.attribute
7d445685-8192-467b-ada1-1fae0c55d63a	true	access.token.claim
7d445685-8192-467b-ada1-1fae0c55d63a	realm_access.roles	claim.name
7d445685-8192-467b-ada1-1fae0c55d63a	String	jsonType.label
a8f1f05f-e7ba-4cdd-898b-f345af3ebbf6	true	multivalued
a8f1f05f-e7ba-4cdd-898b-f345af3ebbf6	foo	user.attribute
a8f1f05f-e7ba-4cdd-898b-f345af3ebbf6	true	access.token.claim
a8f1f05f-e7ba-4cdd-898b-f345af3ebbf6	resource_access.${client_id}.roles	claim.name
a8f1f05f-e7ba-4cdd-898b-f345af3ebbf6	String	jsonType.label
b57e9183-70bd-47b5-bbcc-f46d165054d0	true	userinfo.token.claim
b57e9183-70bd-47b5-bbcc-f46d165054d0	username	user.attribute
b57e9183-70bd-47b5-bbcc-f46d165054d0	true	id.token.claim
b57e9183-70bd-47b5-bbcc-f46d165054d0	true	access.token.claim
b57e9183-70bd-47b5-bbcc-f46d165054d0	upn	claim.name
b57e9183-70bd-47b5-bbcc-f46d165054d0	String	jsonType.label
2f7c9fd1-4fd0-4e33-b58c-c193a54a9478	true	multivalued
2f7c9fd1-4fd0-4e33-b58c-c193a54a9478	foo	user.attribute
2f7c9fd1-4fd0-4e33-b58c-c193a54a9478	true	id.token.claim
2f7c9fd1-4fd0-4e33-b58c-c193a54a9478	true	access.token.claim
2f7c9fd1-4fd0-4e33-b58c-c193a54a9478	groups	claim.name
2f7c9fd1-4fd0-4e33-b58c-c193a54a9478	String	jsonType.label
7b81f46f-a8f9-46c9-9e61-4e4ba4e12e32	true	userinfo.token.claim
7b81f46f-a8f9-46c9-9e61-4e4ba4e12e32	locale	user.attribute
7b81f46f-a8f9-46c9-9e61-4e4ba4e12e32	true	id.token.claim
7b81f46f-a8f9-46c9-9e61-4e4ba4e12e32	true	access.token.claim
7b81f46f-a8f9-46c9-9e61-4e4ba4e12e32	locale	claim.name
7b81f46f-a8f9-46c9-9e61-4e4ba4e12e32	String	jsonType.label
3a1d6e13-865f-4851-90dd-ab9cbedff475	clientId	user.session.note
3a1d6e13-865f-4851-90dd-ab9cbedff475	true	id.token.claim
3a1d6e13-865f-4851-90dd-ab9cbedff475	true	access.token.claim
3a1d6e13-865f-4851-90dd-ab9cbedff475	clientId	claim.name
3a1d6e13-865f-4851-90dd-ab9cbedff475	String	jsonType.label
68e44953-9083-488c-be5e-b1c41bcf7a73	clientHost	user.session.note
68e44953-9083-488c-be5e-b1c41bcf7a73	true	id.token.claim
68e44953-9083-488c-be5e-b1c41bcf7a73	true	access.token.claim
68e44953-9083-488c-be5e-b1c41bcf7a73	clientHost	claim.name
68e44953-9083-488c-be5e-b1c41bcf7a73	String	jsonType.label
287858ff-d6bb-4eb9-895e-f9e8fbc61f39	clientAddress	user.session.note
287858ff-d6bb-4eb9-895e-f9e8fbc61f39	true	id.token.claim
287858ff-d6bb-4eb9-895e-f9e8fbc61f39	true	access.token.claim
287858ff-d6bb-4eb9-895e-f9e8fbc61f39	clientAddress	claim.name
287858ff-d6bb-4eb9-895e-f9e8fbc61f39	String	jsonType.label
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
master	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	afddb56d-0c09-4bb5-ba70-3d594f19d404	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	b26d517f-fe54-4ef2-9f85-e802b27b5074	23d319c4-c287-407b-a86b-e3cc4c11ef4e	52418229-2554-4b7d-8b4e-799635d9ed7b	b8105554-1902-4f9b-b81f-24b9afa98258	e9567cb7-01f7-4a2c-929a-3f33908f2254	2592000	f	900	t	f	079b613e-85ee-4499-ba03-937467d0aa0e	0	f	0	0	4a924ab3-e9d2-45af-9730-1723081a34d5
MAG	60	300	300	\N	\N	\N	t	f	0	\N	MAG	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	5f12ca42-1560-4c3a-bd42-ac550e7d341c	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	1d84df76-7e1e-4a9e-b73d-73e4407c683b	5b999054-9538-4ccd-a5b0-a0b38fba68c4	dd2f7d23-e7db-441d-b891-2d228aba1724	da260cbb-64f4-4ebe-81a5-7a18b9d2daaf	8c20b949-dcbf-44e9-82ab-2ef4481203a7	2592000	f	900	t	f	1abc0bb6-7d1c-47df-a9e5-0975a15f5b04	0	f	0	0	64c8f33d-3a88-47d5-ae85-e7709b3c92bf
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: -
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
oauth2DeviceCodeLifespan	MAG	600
oauth2DevicePollingInterval	MAG	5
cibaBackchannelTokenDeliveryMode	MAG	poll
cibaExpiresIn	MAG	120
cibaInterval	MAG	5
cibaAuthRequestedUserHint	MAG	login_hint
bruteForceProtected	MAG	false
permanentLockout	MAG	false
maxFailureWaitSeconds	MAG	900
minimumQuickLoginWaitSeconds	MAG	60
waitIncrementSeconds	MAG	60
quickLoginCheckMilliSeconds	MAG	1000
maxDeltaTimeSeconds	MAG	43200
failureFactor	MAG	30
actionTokenGeneratedByAdminLifespan	MAG	43200
actionTokenGeneratedByUserLifespan	MAG	300
defaultSignatureAlgorithm	MAG	RS256
offlineSessionMaxLifespanEnabled	MAG	false
offlineSessionMaxLifespan	MAG	5184000
clientSessionIdleTimeout	MAG	0
clientSessionMaxLifespan	MAG	0
clientOfflineSessionIdleTimeout	MAG	0
clientOfflineSessionMaxLifespan	MAG	0
webAuthnPolicyRpEntityName	MAG	keycloak
webAuthnPolicySignatureAlgorithms	MAG	ES256
webAuthnPolicyRpId	MAG	
webAuthnPolicyAttestationConveyancePreference	MAG	not specified
webAuthnPolicyAuthenticatorAttachment	MAG	not specified
webAuthnPolicyRequireResidentKey	MAG	not specified
webAuthnPolicyUserVerificationRequirement	MAG	not specified
webAuthnPolicyCreateTimeout	MAG	0
webAuthnPolicyAvoidSameAuthenticatorRegister	MAG	false
webAuthnPolicyRpEntityNamePasswordless	MAG	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	MAG	ES256
webAuthnPolicyRpIdPasswordless	MAG	
webAuthnPolicyAttestationConveyancePreferencePasswordless	MAG	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	MAG	not specified
webAuthnPolicyRequireResidentKeyPasswordless	MAG	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	MAG	not specified
webAuthnPolicyCreateTimeoutPasswordless	MAG	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	MAG	false
client-policies.profiles	MAG	{"profiles":[]}
client-policies.policies	MAG	{"policies":[]}
_browser_header.contentSecurityPolicyReportOnly	MAG	
_browser_header.xContentTypeOptions	MAG	nosniff
_browser_header.xRobotsTag	MAG	none
_browser_header.xFrameOptions	MAG	SAMEORIGIN
_browser_header.contentSecurityPolicy	MAG	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	MAG	1; mode=block
_browser_header.strictTransportSecurity	MAG	max-age=31536000; includeSubDomains
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
MAG	1b5c0d65-8666-4805-b046-d2adbac999d3
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
master	jboss-logging
MAG	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	master
password	password	t	t	MAG
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
MAG		starttls
MAG	25	port
MAG		auth
MAG	mailgw.it.unideb.hu	host
MAG	no-reply@magpraktikum.hu	from
MAG	DEV Mag Praktikum Rendszer	fromDisplayName
MAG		ssl
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.redirect_uris (client_id, value) FROM stdin;
df754331-dc4c-4886-aa39-4a7ac747b383	/realms/master/account/*
8433c1fd-5ede-4535-a056-2e4b8c0a289a	/realms/master/account/*
9b7ac9ff-5213-44a3-988c-a6f181f31507	/admin/master/console/*
006df867-19d0-4bbc-9de7-f01ca96aaf7a	/realms/MAG/account/*
87ae7e2b-85a5-4f5c-a55b-4596d7dd3baa	/realms/MAG/account/*
f0f69f18-4c7f-4850-a6f3-8bc4b0189408	/admin/MAG/console/*
0ac48ba0-1e20-4236-8749-bed43d1a2737	*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
2ac3e35b-0a4a-424e-abd7-51dd5d49107f	VERIFY_EMAIL	Verify Email	master	t	f	VERIFY_EMAIL	50
4dbcc383-0317-4009-9327-4311a832949a	UPDATE_PROFILE	Update Profile	master	t	f	UPDATE_PROFILE	40
4bee35e2-cf17-4b38-b47b-9ea39a41dcd8	CONFIGURE_TOTP	Configure OTP	master	t	f	CONFIGURE_TOTP	10
821a958f-76bb-416d-a09f-9ea2a37e8821	UPDATE_PASSWORD	Update Password	master	t	f	UPDATE_PASSWORD	30
e00aaeaa-2ca8-4f12-90e7-25e759d57181	terms_and_conditions	Terms and Conditions	master	f	f	terms_and_conditions	20
e93affe6-e25c-471b-961e-33aa6d5df184	update_user_locale	Update User Locale	master	t	f	update_user_locale	1000
64e03cc1-5586-4832-be85-5ea5ad2d187b	delete_account	Delete Account	master	f	f	delete_account	60
61d742fb-4bce-4f94-8b2a-745923d0658e	VERIFY_EMAIL	Verify Email	MAG	t	f	VERIFY_EMAIL	50
5b9b2b92-ff1e-401d-86f6-ca7ff048fa72	UPDATE_PROFILE	Update Profile	MAG	t	f	UPDATE_PROFILE	40
698a0fda-5aa3-4498-a555-53410d662de3	CONFIGURE_TOTP	Configure OTP	MAG	t	f	CONFIGURE_TOTP	10
b9b4a8b5-6f28-4f82-9a51-49501a7ec4d4	UPDATE_PASSWORD	Update Password	MAG	t	f	UPDATE_PASSWORD	30
dc78799d-f5e8-47d4-b4e5-20338817f89c	terms_and_conditions	Terms and Conditions	MAG	f	f	terms_and_conditions	20
5b343c54-c3ff-43dd-825c-fb7d838faecf	update_user_locale	Update User Locale	MAG	t	f	update_user_locale	1000
7e642d8c-e44a-44e2-ac18-e5bd0763ff93	delete_account	Delete Account	MAG	f	f	delete_account	60
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
57d0ab0d-d25b-4b1d-91ee-1ed79754e651	f	0	1
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: -
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
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_uris (resource_id, value) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
8433c1fd-5ede-4535-a056-2e4b8c0a289a	f236e675-8505-423f-9cdd-b3f063b15572
87ae7e2b-85a5-4f5c-a55b-4596d7dd3baa	ace9a4e6-d3d9-4c51-8c24-2ec63a4d1f52
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_attribute (name, value, user_id, id) FROM stdin;
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
97f3b26f-a6ee-44c9-b682-b86d0be2667e	\N	e73b3154-0566-4241-bbcc-f530331f1804	f	t	\N	\N	\N	master	admin	1634204294334	\N	0
7862f557-1660-44f8-8596-bb9b6517848c	admin@mag.com	admin@mag.com	t	t	\N	Admin	Teszt	MAG	admin	1634207022281	\N	0
cd81ac3c-2cf4-4eae-a8d7-92134c2ee573	portal.editor@mag.com	portal.editor@mag.com	t	t	\N	Editor	Portal	MAG	portal_editor	1636034397129	\N	0
39032731-308a-40be-92d8-c67f957422fb	company_admin@mag.com	company_admin@mag.com	t	t	\N	Admin	Company	MAG	company_admin	1636034453870	\N	0
56544d30-bb5b-4071-9b7a-bb41e5b564b7	company.contat.person@mag.com	company.contat.person@mag.com	t	t	\N	Person	Company Contact	MAG	company_contact_person	1636034522802	\N	0
1767b4c5-90ff-4365-a2f9-c811bb4788b9	major.lead@mag.com	major.lead@mag.com	t	t	\N	Lead	Major	MAG	major_lead	1636034582977	\N	0
61f434f7-7198-45b0-8f83-5457d84756fb	student@mag.com	student@mag.com	f	t	\N	Student	Student	MAG	student	1636034627133	\N	0
db231577-4404-4e0e-a5c2-9a332293b307	study.department@mag.com	study.department@mag.com	t	t	\N	Department	Study	MAG	study_department	1636034676847	\N	0
f3a7e2a1-540d-437d-b211-f33835f8017b	\N	a2458970-ffc0-4507-bed7-ef566ef4546b	f	t	\N	\N	\N	MAG	service-account-admin-mag	1638445063996	99ad60bc-04f5-47b9-9f23-3ec0fa4a67e8	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_group_membership (group_id, user_id) FROM stdin;
1f46f199-ece2-4aa5-b727-d20254c88f88	7862f557-1660-44f8-8596-bb9b6517848c
1b5c0d65-8666-4805-b046-d2adbac999d3	7862f557-1660-44f8-8596-bb9b6517848c
1b5c0d65-8666-4805-b046-d2adbac999d3	cd81ac3c-2cf4-4eae-a8d7-92134c2ee573
950afbf7-d362-4cbf-b3b4-d516f31e9c06	cd81ac3c-2cf4-4eae-a8d7-92134c2ee573
1b5c0d65-8666-4805-b046-d2adbac999d3	39032731-308a-40be-92d8-c67f957422fb
6b31c531-1f16-47f0-910f-f2444b897626	39032731-308a-40be-92d8-c67f957422fb
1b5c0d65-8666-4805-b046-d2adbac999d3	56544d30-bb5b-4071-9b7a-bb41e5b564b7
eedf0c9d-4d86-463a-9823-a121df0e0030	56544d30-bb5b-4071-9b7a-bb41e5b564b7
1b5c0d65-8666-4805-b046-d2adbac999d3	1767b4c5-90ff-4365-a2f9-c811bb4788b9
83a5aa3e-cb59-498a-a6c1-0ec4881e05ed	1767b4c5-90ff-4365-a2f9-c811bb4788b9
1b5c0d65-8666-4805-b046-d2adbac999d3	61f434f7-7198-45b0-8f83-5457d84756fb
4328acf2-3727-4c4a-ab55-e52a6dd53754	61f434f7-7198-45b0-8f83-5457d84756fb
1b5c0d65-8666-4805-b046-d2adbac999d3	db231577-4404-4e0e-a5c2-9a332293b307
f7553629-b634-46dd-93b1-2c6d427e5938	db231577-4404-4e0e-a5c2-9a332293b307
1b5c0d65-8666-4805-b046-d2adbac999d3	f3a7e2a1-540d-437d-b211-f33835f8017b
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
4a924ab3-e9d2-45af-9730-1723081a34d5	97f3b26f-a6ee-44c9-b682-b86d0be2667e
017a5b0c-2639-4149-9f37-9452dc8ff121	97f3b26f-a6ee-44c9-b682-b86d0be2667e
64c8f33d-3a88-47d5-ae85-e7709b3c92bf	7862f557-1660-44f8-8596-bb9b6517848c
64c8f33d-3a88-47d5-ae85-e7709b3c92bf	cd81ac3c-2cf4-4eae-a8d7-92134c2ee573
64c8f33d-3a88-47d5-ae85-e7709b3c92bf	39032731-308a-40be-92d8-c67f957422fb
64c8f33d-3a88-47d5-ae85-e7709b3c92bf	56544d30-bb5b-4071-9b7a-bb41e5b564b7
64c8f33d-3a88-47d5-ae85-e7709b3c92bf	1767b4c5-90ff-4365-a2f9-c811bb4788b9
64c8f33d-3a88-47d5-ae85-e7709b3c92bf	61f434f7-7198-45b0-8f83-5457d84756fb
64c8f33d-3a88-47d5-ae85-e7709b3c92bf	db231577-4404-4e0e-a5c2-9a332293b307
64c8f33d-3a88-47d5-ae85-e7709b3c92bf	f3a7e2a1-540d-437d-b211-f33835f8017b
8e70c551-ae07-46d2-84a4-a295447c2869	f3a7e2a1-540d-437d-b211-f33835f8017b
44f9a8ab-add5-4a9d-985a-db30e70fa3cf	f3a7e2a1-540d-437d-b211-f33835f8017b
fa453334-d981-4997-9815-390e2564a8b5	f3a7e2a1-540d-437d-b211-f33835f8017b
a7ab5d31-0388-46ca-9ac0-30002f493981	f3a7e2a1-540d-437d-b211-f33835f8017b
ad7221e6-5a5e-48ec-9695-6d4299afdfc7	f3a7e2a1-540d-437d-b211-f33835f8017b
3213f038-f1e6-46a7-a719-2bd956751c0d	f3a7e2a1-540d-437d-b211-f33835f8017b
b4e94c7e-2bfa-436c-b967-1e0060018b60	f3a7e2a1-540d-437d-b211-f33835f8017b
28f37dc9-4a17-489f-8a58-b998b5791583	f3a7e2a1-540d-437d-b211-f33835f8017b
83c9992d-55a4-4588-8cfb-8349167a6d7e	f3a7e2a1-540d-437d-b211-f33835f8017b
96fcc8f8-c9fc-4fb5-96ec-4207aacad947	f3a7e2a1-540d-437d-b211-f33835f8017b
c8081ddd-a50b-460c-ae4e-aa93b043594a	f3a7e2a1-540d-437d-b211-f33835f8017b
5db7a446-8b92-4d12-b928-42b387220c63	f3a7e2a1-540d-437d-b211-f33835f8017b
8c7bebbb-5060-40b1-95d3-fd4219296dd9	f3a7e2a1-540d-437d-b211-f33835f8017b
\.


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.web_origins (client_id, value) FROM stdin;
9b7ac9ff-5213-44a3-988c-a6f181f31507	+
f0f69f18-4c7f-4850-a6f3-8bc4b0189408	+
0ac48ba0-1e20-4236-8749-bed43d1a2737	*
\.


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: databasechangeloglock pk_databasechangeloglock; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT pk_databasechangeloglock PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, value);


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_css_preload; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_offline_css_preload ON public.offline_client_session USING btree (client_id, offline_flag);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_offline_uss_by_usersess; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_offline_uss_by_usersess ON public.offline_user_session USING btree (realm_id, offline_flag, user_session_id);


--
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_offline_uss_createdon ON public.offline_user_session USING btree (created_on);


--
-- Name: idx_offline_uss_preload; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_offline_uss_preload ON public.offline_user_session USING btree (offline_flag, created_on, user_session_id);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

