# NixOS Image Types

We use `images.iso` (~415 MB) instead of `images.iso-installer` (~1.2 GB)
because the latter builds the standard NixOS installer ISO image (without our SSH key etc.),
which is not what we want here.
