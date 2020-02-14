const mongoose = require('mongoose')

module.exports = {
  connect: () => {
    let connectString = `mongodb://${process.env.DB_USER}:${process.env.DB_PASS}@${process.env.DB_HOST}:${process.env.DB_PORT}/${process.env.DB_NAME}`
    // let connectString2 = `mongodb://${process.env.DB_HOST}:${process.env.DB_PORT}/${process.env.DB_NAME}`
    console.log(connectString)
    mongoose.connect(connectString, {useNewUrlParser: true, useUnifiedTopology: true})
      .then(() => {
        console.log('[MongoDB] Connected !')
      })
      .catch(err => {
        console.log('[MongoDB] Error connecting to the database : ' + err)
      })
  }
}
