template quattor/aii/freeipa/default;

include { 'quattor/aii/freeipa/schema' };


variable FREEIPA_AII_DOMAIN ?= undef;
variable FREEIPA_AII_SERVER ?= undef;
variable FREEIPA_AII_REALM ?= undef;

variable FREEIPA_AII_DNS ?= false;
variable FREEIPA_AII_DISABLE ?= true;


variable FREEIPA_HOOK_BOOT ?= which_hook_is_next("/system/aii/hooks/boot");

"/system/aii/hooks/boot/" = {
    SELF[FREEIPA_HOOK_BOOT] = nlist(
        'module', FREEIPA_AII_MODULE_NAME,
        
        'domain', FREEIPA_AII_DOMAIN,
        'server', FREEIPA_AII_SERVER,
        'realm', FREEIPA_AII_REALM,

        'dns', FREEIPA_AII_DNS,
        );

    SELF;
};

bind "/system/aii/hooks" = nlist with validate_aii_freeipa_hooks('boot');


variable FREEIPA_HOOK_REMOVE ?= which_hook_is_next("/system/aii/hooks/remove/");

"/system/aii/hooks/remove/" = {
    SELF[FREEIPA_HOOK_REMOVE] = nlist(
        'module', FREEIPA_AII_MODULE_NAME,
        'disable', FREEIPA_AII_DISABLE
        );

    SELF;
};

bind "/system/aii/hooks" = nlist with validate_aii_freeipa_hooks('remove');


