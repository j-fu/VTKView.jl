[![](https://img.shields.io/badge/docs-dev-blue.svg)](https://j-fu.github.io/VTKView.jl/dev)

# VTKView.jl: VTK based visualization

Some features:
- Fast visualization of
  - 2D, 3D rectilinear and simplicial grids
  - Piecewise linear functions on these grids
  - 1D x-y plot data
- Keyboard and mouse based interaction in graphics window
- Rendering is performed in a separate thread
- PNG+VTK output, video recording


VTKView wraps [vtkfig](https://github.com/j-fu/vtkfig), a C++ graphics library with an API that attempts to be easy  to use from C/C++ simulation codes. It uses [vtk](https://vtk.org) for fast rendering of data. Based on ccall and the C API of vtkfig, VTKView makes this functionality available in Julia. 

## Disclaimer

So far, this package is in an early state. In particular, the relevant binary packages for MacOS and Windows are not yet available, and therefore they are registered with the general registry. During the early devlopment phase, these, and the current version  of the code
are avilable via the registry https://github.com/j-fu/PackageNursery.git . The artifacts for Linux and FreeBSD are available, but vtk is not officially supported for FreeBSD and Linux with musl libc.

## Installation 

### Installation via package manager (Linux, FreeBSD)

1. Add another registry to the package manager (for finding  the jlls for vtk):  
```
pkg> registry add https://github.com/j-fu/PackageNursery.jl.git
```
2. Install this package:   
```
pkg> add VTKView
```
   You will have to choose between the version from the General registry and the one from the PackageNursery. Choose the later (with the UUID starting with `63b67fce`)


3. Run examples:
```
using VTKView
VTKView.Examples.all()
```

### Manual installation  (Linux MacOSX and the Win10 linux environment should be similar)

1. Install vtk 8.2 or vtk 9.0.0 and the respective development files on your system.
   This can be done either via your system's package manager, or by downloading vtk and following the compilation instructions. Please ensure that all header files are installed as well. When configuring, care about
   ensuring that graphics acceleration is enabled. See [here](https://github.com/j-fu/vtkfig/blob/master/doc/vtkminimal.md) for information on compiling a minimal subset for working with vtkfig.

2. Download (clone) vtkfig and install it using the instructions of that package. 

3. Set the environment variable `LIBVTKFIG` such that it points to `libvtkfig.so`

4. Add this package to your Julia environment
`pkg> add VTKView`

5. Run examples:
```
using VTKView
VTKView.Examples.all()
```

## Other VTK related Julia resources

- [WriteVTK.jl](https://github.com/jipolanco/WriteVTK.jl): Package allowing to write vtk files for later visualization with paraview.
- [VTK.jl](https://github.com/timholy/VTK.jl): An early attempt to wrap the VTK API.  
  Note that vtkfig, and thus VTKView work on top of the vtk API. In vtk speak, vtkfig just provides a couple of pre-defined vtk pipelines.
- [VTKDataTypes.jl](https://github.com/mohamed82008/VTKDataTypes.jl): representing VTK data types and manipulating them in Julia.
- [VTKDataIO.jl](https://github.com/mohamed82008/VTKDataIO.jl):  reading, writing and visualizing mesh data.  
  This package uses VTK through its python interface.
