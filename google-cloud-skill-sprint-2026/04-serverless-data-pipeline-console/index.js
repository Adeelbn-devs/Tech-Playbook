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

  // Resize image to 64x64 using Sharp
  const thumbnailBuffer = await sharp(imageBuffer).resize(64, 64).toBuffer();

  const thumbFileName = `thumb_${path.basename(fileName)}`;
  await bucket.file(thumbFileName).save(thumbnailBuffer, {
    metadata: { contentType: file.contentType },
  });

  // Publish metadata to Pub/Sub
  const messagePayload = Buffer.from(
    JSON.stringify({