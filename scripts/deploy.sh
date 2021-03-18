#!/bin/sh

echo "Deploy to CDN"

BUCKET=s3://cdn.tecnologia.senior.com.br/platform/tecnologia-design-tokens/

aws s3 sync ${BASE_PATH}dist ${BUCKET}${GITHUB_REF##*/} --delete

echo "Copy to S3 concluded"
echo "Prepare to invalidade cache on CloudFront"

aws cloudfront create-invalidation --distribution-id ${AWS_CLOUDFRONT_DIST_ID} --paths "/platform/tecnologia-design-tokens/${GITHUB_REF##*/}/*"

if [ ! -f $VERSION ]; then
  echo "Uploading to $VERSION folder!"

  aws s3 sync ${BASE_PATH}dist ${BUCKET}${VERSION}
  aws cloudfront create-invalidation --distribution-id ${AWS_CLOUDFRONT_DIST_ID} --paths "/platform/tecnologia-design-tokens/${VERSION}/*"
fi
