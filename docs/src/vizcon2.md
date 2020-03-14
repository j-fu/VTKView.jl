

Intro
=======================================

__vizcon2: VTKView.jl -- vtk based in-situ visualization  in Julia__

__Jürgen Fuhrmann__

__Weierstrass Institute  (WIAS) Berlin__

`github.com/j_fu`



My secret interest in visualization
=================================

## Idea
- __Duty:__ Numerical Math, PDE based simulation algorithms, application projects
- __Secret interest:__ in-situ visualization from within 1/2/3D unstructured grid PDE solvers
  - Plot output during simulation run
  - Non-intrusive API so it can be added to any code
  - Utilization of GPU hardware

## History
- Did use some GKS in the early times
- Rolled my own: `gms`  (now on github)
- Switched to OpenGL: `gltools`   (now on github)
  - Uses fixed function pipeline OpenGL standard
  - `gltools2` with FLTK gui included in WIAS simulation code  
    (we think about making this available to Julia)
- `vtkfig`

Why vtk ?
================================
- __Fixed function  pipeline OpenGL deprecated__
- Don't want to mess with shaders, Vulkan etc.
- Very few  intermediate level interfaces for GPU graphics available  
  -  `three.js` but this sits in the browser  
  - Josef Heinen's `gr`, but this also uses fixed function pipeline
  - Big chance for Makie also outside of Julia
- VTK provides high level primitives for grid data based visualization  
  So why not... ?

VTK
================================
- `https://vtk.org`
- Started in 1993
- BSD license
- Well maintained, reasonable evolution with legacy edges
  - Modern OpenGL
  - hopefully Vulkan  
    (fresh request:  https://discourse.vtk.org/t/update-on-vulkan-support/2819 )
  - smart pointers
  - C++11 features
  - First class citizen of CMake universe (both maintained by Kitware)
- Library behind Paraview, VisIt ...
- used by US labs ==> big  interest (IMHO) in keeping this going
- ==> investment in learning appears to be  safe.

## Some cons
- Lots of examples available, but steep learning curve nevertheless
- Event loop based API hard to incorporate into simulation codes
- Rather ugly plot attributes
- It's *YUGE*



VTK basic structure + features
================================
- Fill `vtkDataSet` with grid, point scalars etc.  
  (more or less 1:1 mapping with VTK files)
- Create rendering pipelines by chaining various filters to extract isolines, apply colors ...
   - some similarity with Makie's `lift` 
   - Paraview is the GUI for this
```
isoline_filter->SetInputConnection(transgeometry->GetOutputPort());
```
- Create Actors which make things visible on the screen


`vtkfig` aka fixed rendering pipeline VTK viewer
===============================================
- `https://github.com/j_fu/vtkfig`
- Several fixed but configurable pipelines for standard visualization tasks
  - `vtkfig::Figure`
     - `vtkfig::ScalarView`
     - `vtkfig::VectorView`
     - `vtkfig::GridView`
     - `vtkfig::XYPlot`
- Figures can be added to a `vtkfig::Frame`
- Event loop and rendering  in separate thread  
  At the cost of having all data copied ...
- Interactivity inherited from vtk
- File output: images, video, vtk 
- Duck typing based API for filling data structures  
  ==> easy integration into C++ code
- Memory management via  C++11 `std::shared_ptr` 
- Additional C API
- Builds on Linux, MacOS, Unix Subsystem of Win10

`VTKView.jl` 
===============================================
- `https://github.com/j_fu/VTKView.jl`
- Make `vtkfig` available from Julia
- Integration via C API and `ccall`
- Attempt on a more "julian" API
- No precompilation time ;-)

Plans
===============================================

## `vtkfig`
- One thread per frame in multiple frame case
- No time for GUI...
- Try out Paraview catalyst (send vtkDataset to Paraview)
- Try out higher order elements (vtk has some stuff for this)

## `VTKView.jl` 
- Map full API of vtkfig (still missing streamlines some state toggles)
- jll 
  - builds with vtk-8.2.0 but only without cross compiling  
    jll works for linux-x86_64
  - vtk-9.0.0 seems to support cross compiling  
    need to learn how to export cross compilation tools to client codes ...

### Ideas 
  - Backend for plot recipes ?
