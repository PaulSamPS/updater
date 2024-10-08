import fs from 'fs';
import fsPromises from 'fs/promises';
import mime from 'mime';
import { NextApiRequest, NextApiResponse } from 'next';
import nullthrows from 'nullthrows';
import path from 'path';
import {
  getLatestUpdateBundlePathForRuntimeVersionAsync,
  getMetadataAsync,
} from '../../common/helpers';

export const config = {
  api: {
    responseLimit: false,
  },
};

export default async function assetsEndpoint(req: NextApiRequest, res: NextApiResponse) {
  const { asset: assetName, runtimeVersion, platform } = req.query;

  if (!assetName || typeof assetName !== 'string') {
    res.statusCode = 400;
    res.json({ error: 'No asset name provided.' });
    return;
  }

  if (platform !== 'ios' && platform !== 'android') {
    res.statusCode = 400;
    res.json({ error: 'No platform provided. Expected "ios" or "android".' });
    return;
  }

  if (!runtimeVersion || typeof runtimeVersion !== 'string') {
    res.statusCode = 400;
    res.json({ error: 'No runtimeVersion provided.' });
    return;
  }

  let updateBundlePath: string;
  try {
    updateBundlePath = await getLatestUpdateBundlePathForRuntimeVersionAsync(runtimeVersion);
  } catch (error: any) {
    res.statusCode = 404;
    res.json({
      error: error.message,
    });
    return;
  }

  const { metadataJson } = await getMetadataAsync({
    updateBundlePath,
    runtimeVersion,
  });

  const assetPath = path.resolve(assetName);

  const assetMetadata = metadataJson.fileMetadata[platform].assets
    .map((asset: any) => {
      return asset.path.replace(/\\/g, '/');
    })
    .filter((asset: any) => asset !== null && asset !== undefined)
    .find((asset: any) => {
      const targetPath = assetName.replace(`${updateBundlePath}/`, '');
      return asset === targetPath;
    });
  const isLaunchAsset =
    metadataJson.fileMetadata[platform].bundle === assetName.replace(`${updateBundlePath}/`, '');

  if (!fs.existsSync(assetPath)) {
    res.statusCode = 404;
    res.json({ error: `Asset "${assetName}" does not exist.` });
    return;
  }

  try {
    const asset = await fsPromises.readFile(assetPath, null);

    res.statusCode = 200;
    res.setHeader(
      'content-type',
      isLaunchAsset
        ? 'application/javascript'
        : assetMetadata
        ? mime.getType(assetMetadata.ext) ?? 'application/octet-stream'
        : 'application/octet-stream'
    );
    res.end(asset);
  } catch (error) {
    console.log(error);
    res.statusCode = 500;
    res.json({ error });
  }
}
