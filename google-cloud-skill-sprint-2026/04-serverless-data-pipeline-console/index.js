const { Storage } = require('@google-cloud/storage');
const { PubSub } = require('@google-cloud/pubsub');
const sharp = require('sharp');
const path = require('path');

const storage = new Storage();
const pubsub = new PubSub();
const TOPIC_NAME = process.env.PUBSUB_TOPIC || 'thumbnail-events';

exports.generateThumbnail = async (cloudEvent) => {
 const file = cloudEvent.data;
  const fileName = file.name;

  // Infinite-loop prevention guard
  if (!fileName || fileName.startsWith('thumb_') || !file.contentType?.startsWith('image/')) {
    console.log(`Skipping file: ${fileName}`);
    return;
  }

  const bucket = storage.bucket(file.bucket);
  const [imageBuffer] = await bucket.file(fileName).download();
