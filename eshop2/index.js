/**
 * Eshop Express server with static resources.
 */
"use strict";

const port    = process.env.DBWEBB_PORT || 1337;
const path    = require("path");
const express = require("express");
const app     = express();
const routeEshop = require("./route/eshop.js");
const middleware = require("./middleware/index.js");

app.set("view engine", "ejs");

app.use(middleware.logIncomingToConsole);
app.use(express.static(path.join(__dirname, "public")));
app.use(express.urlencoded({ extended: true }));
app.use("/eshop", routeEshop);
app.listen(port, logStartUpDetailsToConsole);


/**
 * Log app details to console when starting up.
 *
 * @return {void}
 */
function logStartUpDetailsToConsole() {
    let routes = [];

    app._router.stack.forEach((middleware) => {
        if (middleware.route) {
            routes.push(middleware.route);
        } else if (middleware.name === "router") {
            middleware.handle.stack.forEach((handler) => {
                let route;

                route = handler.route;
                route && routes.push(route);
            });
        }
    });

    console.info(`Server is listening on port ${port}.`);
    console.info("Available routes are:");
    console.info(routes);
}
