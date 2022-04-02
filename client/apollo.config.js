module.exports = {
  client: {
    service: {
      name: "todo-list-app",
      url: "http://localhost:3000/graphql",
    },

    includes: ["src/**/*.vue", "src/**/*.js", "src/**/*.ts"],
  },
};
