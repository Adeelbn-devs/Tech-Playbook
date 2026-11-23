const { Storage } = require('@google-cloud/storage');
const { PubSub } = require('@google-cloud/pubsub');
const sharp = require('sharp');
const path = require('path');

const storage = new Storage();
const pubsub = new PubSub();
const TOPIC_NAME = process.env.PUBSUB_TOPIC || 'thumbnail-events';

exports.generateThumbnail = async (cloudEvent) => {
  const bucketName = cloudEvent.data.bucket;
  const fileName = cloudEvent.data.name;