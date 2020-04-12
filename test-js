YAML = require("yaml")

module.exports.endpoint = function(req, res) {
  const pageName = req.url.substr(1);
  res.setHeader("Content-Type", "application/json");
  const request = require("request");
  let statusObject;
  const url = "https://raw.githubusercontent.com/riccardoporreca/test-utterances/master/results.yaml";
  request(url, function(error, response, body) {
    if (!error && response.statusCode === 200) {
      statusObject = YAML.parse(body);
      var message = statusObject[pageName];
      var color;
      switch(statusObject[pageName]) {
        case "accepted":
          color = "778bc5";
          break;
        case "Finalist":
          color = "green";
          break;
        case "Gold medal":
          // https://www.rapidtables.com/web/color/Gold_Color.html
          color = "D4AF37";
          break;
        case "Community medal":
          color = "ec7623";
          break;
        default:
          message = "No submission found";
          color = "red";
      }; 
      res.end(JSON.stringify({
        schemaVersion: 1,
        labelColor: "2b3990",
        label: "eRum2020::CovidR",
        message: message,
        color: color
      }));
    }
  });
}
