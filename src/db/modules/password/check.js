const bcrypt = require("bcryptjs");

module.exports = (plain, hashed) => bcrypt.compareSync(plain, hashed);
