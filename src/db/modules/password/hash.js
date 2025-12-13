const bcrypt = require("bcryptjs");

const saltRounds = 15;

module.exports = (password) => bcrypt.hashSync(password, saltRounds);
