var args = require('optimist')
           .alias('h', 'vhost')
           .alias('e', 'endpoint')
           .alias('a', 'alias')
           .alias('r', 'reload').argv,
    fs   = require('fs');

var config_file = './vhost-routes.json';

function write_config(cfg) {
    fs.writeFile(config_file, JSON.stringify(cfg, null, 2));
    console.log("Wrote new config.");
}

function add_vhost(vhost, endpoint) {
    console.log("Adding vhost: " + vhost + " endpoint: " + endpoint);
}

function remove_vhost(vhost) {
    console.log("Removing vhost: " + vhost);

    var cfg = require(config_file);
    if (!cfg[vhost]) {
        console.log("Vhost: " + vhost + " not found in cfg");
        process.exit(0);
    } else {
        delete cfg[vhost];
        write_config(cfg);
    }
}

function alias_vhost(vhost, alias) {
    console.log("Adding alias: " + alias + " for: " + vhost);

    var cfg = require(config_file);
    if (!cfg[vhost]) {
        console.log("Vhost: " + vhost + " not found in cfg");
        process.exit(1);
    } else {
        cfg[alias] = cfg[vhost];
        console.log(cfg[alias]);
        write_config(cfg);
    }
}

function reload_config() {
    console.log("Sending SIGHUP to ws proxy server...");
}

switch (args._[0]) {
    case 'add':
        if (!args.vhost || !args.endpoint) {
            console.log("Please specify vhost and endpoint for add operation.");
            process.exit(1);
        }
        add_vhost(args.vhost, args.endpoint);
        break;

    case 'remove':
        if (!args.vhost) {
            console.log("Please specify vhost for remove operation.");
            process.exit(1);
        }
        remove_vhost(args.vhost);
        break;

    case 'add-alias':
        if (!args.vhost || !args.alias) {
            console.log("Please specify vhost and endpoint for add operation.");
            process.exit(1);
        }
        alias_vhost(args.vhost, args.alias);
        break;

    case 'remove-alias':
        if (!args.vhost || !args.alias) {
            console.log("Please specify vhost for remove operation.");
            process.exit(1);
        }
        remove_vhost(args.alias);
        break;

    case 'default':
        console.log("Please specify one of add, remove or alias");
}

if (args.reload) {
    reload_config();
}
