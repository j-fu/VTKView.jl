[![](https://img.shields.io/badge/docs-stable-blue.svg)](https://j-fu.github.io/VTKView.jl/stable)
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

So far, this package is in an early state.

## Installation 

### Installation via package manager (64 bit linux with libc only)

1. Add another registry to the package manager (for finding  the jlls for vtk):  
```
pkg> registry add https://github.com/j-fu/JFURegistry.git
```
2. Install this package:
```
pkg> add VTKView
```

3. Run examples:
```
using VTKView
VTKView.Examples.all()
```

### Manual installation  (Linux MacOSX and the Win10 linux environment should be similar)

1. Install vtk 8.2 and its development files on your system.
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
