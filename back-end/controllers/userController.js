const express = require("express");
const userLogin = express.Router({ mergeParams: true });
const { postNewUser } = require("../queries/user");
const bcrypt = require("bcrypt");
const passport = require("passport");

userLogin.post("/registration", async (req, res) => {
  try {
    const hashedPassword = await bcrypt.hash(req.body.password, 10);
    const newUser = {
      name: req.body.name,
      email: req.body.email,
      password: hashedPassword,
    };

    const addUser = await postNewUser(newUser);
    if (addUser) {
      delete addUser.password;
      res.status(200).json(addUser);
    } else {
      res.status(400).json({ error: "User with this email already exist" });
    }
  } catch (err) {
    res.status(err.status || 500).json({ error: err.message });
  }
});

userLogin.post("/login/username/password", passport.authenticate("local"), (req, res) => {
  const foundUser = req.user;

  if (foundUser) {
    res.status(200).json(foundUser);
  } else {
    res.status(400).json({ error: "Entered wrong username or password" });
  }
});

module.exports = userLogin;
