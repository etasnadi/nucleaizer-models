# NucleAIzer models

Immutable trained model weights shared by the modern and legacy NucleAIzer
deployments. The binary files are published as assets of the `models-v1`
GitHub Release; they are deliberately not stored in Git or Git LFS.

Required release assets:

- `mask_rcnn_general.h5`
- `mask_rcnn_cytoplasm.h5`
- `mask_rcnn_tissue_bluebrown.h5`
- `mask_rcnn_tissue_pink.h5`

`SHA256SUMS` is the authoritative integrity manifest. Both application
repositories download the assets from the fixed `models-v1` release and refuse
to start if a file does not match its recorded SHA-256 digest.

The local `release-assets/` directory contains the upload-ready files on the
prepared desktop checkout, but its binary contents are ignored by Git.

## Publish

Push this repository first, then create the public GitHub Release:

```bash
git push -u origin main
./publish-release.sh
```

`publish-release.sh` requires the GitHub CLI (`gh`) to be installed and logged
in. Alternatively, create a release tagged `models-v1` in the GitHub web UI and
attach the four files from `release-assets/` plus `SHA256SUMS`.
