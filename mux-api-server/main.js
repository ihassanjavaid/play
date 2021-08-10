require("dotenv").config();
const express = require("express");
const bodyParser = require("body-parser");
const Mux = require("@mux/mux-node");
/* const { Video } = new Mux(
  process.env.MUX_TOKEN_ID,
  process.env.MUX_TOKEN_SECRET
); */
const { Video } = new Mux(
  "53712278-6ee2-4687-ba5c-cb5dbd9dee13",
  "+U0c5miwZ4tR0lB03ofS9pTqIO/caUmQ0wOudwFS9mO3g4750hcCMF5Mm9s6XZPtdh8iFxPGtzd"
);
const app = express();
const port = 3000;

var jsonParser = bodyParser.json();

app.post("/assets", jsonParser, async (req, res) => {
  console.log("BODY: " + req.body.videoUrl);

  const asset = await Video.Assets.create({
    input: req.body.videoUrl,
    playback_policy: "public",
  });

  res.json({
    data: {
      id: asset.id,
      status: asset.status,
      playback_ids: asset.playback_ids,
      created_at: asset.created_at,
    },
  });
});

app.get("/assets", async (req, res) => {
  const assets = await Video.Assets.list();
  console.log('assets requested');
  res.json({
    data: assets.map((asset) => ({
      id: asset.id,
      status: asset.status,
      playback_ids: asset.playback_ids,
      created_at: asset.created_at,
      duration: asset.duration,
      max_stored_resolution: asset.max_stored_resolution,
      max_stored_frame_rate: asset.max_stored_frame_rate,
      aspect_ratio: asset.aspect_ratio,
    })),
  });
});

app.get("/asset", async (req, res) => {
  let videoId = req.query.videoId;
  const asset = await Video.Assets.get(videoId);

  console.log(asset);

  res.json({
    data: {
      id: asset.id,
      status: asset.status,
      playback_ids: asset.playback_ids,
      created_at: asset.created_at,
      duration: asset.duration,
      max_stored_resolution: asset.max_stored_resolution,
      max_stored_frame_rate: asset.max_stored_frame_rate,
      aspect_ratio: asset.aspect_ratio,
    },
  });
});

app.listen(port, () => {
  console.log(`Mux API listening on port ${port}`);
});
