import os

import tifffile
import zarr
import napari

import dask.array as da
import pandas as pd

def single_channel_pyramid(tiff_path, channel):
    print(f"Importing channel {channel} from {tiff_path}")
    tiff = tifffile.TiffFile(tiff_path)

    pyramid = [
        zarr.open(s[channel].aszarr())
        for s in tiff.series[0].levels
    ]

    pyramid = [
        da.from_zarr(z)
        for z in pyramid
    ]

    return pyramid

# Location of exemplar-001
stem = '/workspace/exemplar-001/'
path_mrk = stem + 'markers.csv'
path_img = stem + 'registration/exemplar-001.ome.tif'
path_seg = stem + 'qc/s3seg/unmicst-exemplar-001/cellOutlines.ome.tif'

# Channel names
markers = os.path.join(stem, 'markers.csv')
markers = (pd.read_csv(markers)
            .get('marker_name')
            .tolist())

# Take Hoechst from the first available cycle (which is really cycle 6 for ex001)
dna = single_channel_pyramid(path_img, 0)
viewer = napari.view_image(
     dna, rgb=False, blending='additive',
     colormap='gray', visible=True, opacity=0.2,
     name='DNA1', contrast_limits=[152.0, 49353.0]
    )

napari.run()
