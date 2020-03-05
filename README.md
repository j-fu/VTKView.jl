# VTKView.jl: VTK based visualization

Some features:
- Fast visualization of
  - 2D, 3D rectilinear and simplicial grids
  - Piecewise linear functions on these grids
  - 1D x-y plot data
- Some keyboard and mouse based interaction in graphics window
- Separate rendering thread
- PNG+VTK output, video recording


VTKView wraps [vtkfig](https://github.com/j-fu/vtkfig), a C++ graphics library with an API that attempts to be easy  to use from C/C++ simulation codes. It uses [vtk](https://vtk.org) for fast rendering of data. Based on ccall and the C API of vtkfig, VTKView makes this functionality available in Julia. 

## Disclaimer

So far, this package is in alpha state.

## Installation (Linux. MacOSX and the Win10 linux environment should be similar)

1. Install vtk and its development files on your system.
   This can be done either via your system's package manager, or by downloading vtk and following the compilation instructions. Please ensure that all header files are installed as well. When configuring, care about
   ensuring that graphics acceleration is enabled.

2. Download (clone) vtkfig and install it using the instructions of that package. 

3. Ensure that the directory containing `libvtkfig.so` (resp. `libvtkfig.a`) is on your `LD_LIBRARY_PATH`

4. Add this package to your Julia environment and try examples
