var documenterSearchIndex = {"docs":
[{"location":"#","page":"Home","title":"Home","text":"using Markdown\nMarkdown.parse(\"\"\"\n$(read(\"../../README.md\",String))\n\"\"\")","category":"page"},{"location":"changes/#Changes-1","page":"Changes","title":"Changes","text":"","category":"section"},{"location":"changes/#March-5,-2020-1","page":"Changes","title":"March 5, 2020","text":"","category":"section"},{"location":"changes/#","page":"Changes","title":"Changes","text":"Start registration process","category":"page"},{"location":"vizcon2/#vizcon2-talk-1","page":"vizcon2 talk","title":"vizcon2 talk","text":"","category":"section"},{"location":"vizcon2/#","page":"vizcon2 talk","title":"vizcon2 talk","text":"This is the  source (slightly modified to fit in here and with links added) of my talk given (online) at vizcon2 on March 15, 2020","category":"page"},{"location":"vizcon2/#","page":"vizcon2 talk","title":"vizcon2 talk","text":"vizcon2 talks\nthis talk","category":"page"},{"location":"vizcon2/#Intro-1","page":"vizcon2 talk","title":"Intro","text":"","category":"section"},{"location":"vizcon2/#","page":"vizcon2 talk","title":"vizcon2 talk","text":"vizcon2: VTKView.jl – vtk based in-situ visualization  in Julia","category":"page"},{"location":"vizcon2/#","page":"vizcon2 talk","title":"vizcon2 talk","text":"Jürgen Fuhrmann","category":"page"},{"location":"vizcon2/#","page":"vizcon2 talk","title":"vizcon2 talk","text":"Weierstrass Institute  (WIAS) Berlin","category":"page"},{"location":"vizcon2/#","page":"vizcon2 talk","title":"vizcon2 talk","text":"github.com/j_fu","category":"page"},{"location":"vizcon2/#My-secret-interest-in-visualization-1","page":"vizcon2 talk","title":"My secret interest in visualization","text":"","category":"section"},{"location":"vizcon2/#Idea-1","page":"vizcon2 talk","title":"Idea","text":"","category":"section"},{"location":"vizcon2/#","page":"vizcon2 talk","title":"vizcon2 talk","text":"Duty: Numerical Math, PDE based simulation algorithms, application projects\nSecret interest: in-situ visualization from within 1/2/3D unstructured grid PDE solvers\nPlot output during simulation run\nNon-intrusive API so it can be added to any code\nUtilization of GPU hardware","category":"page"},{"location":"vizcon2/#History-1","page":"vizcon2 talk","title":"History","text":"","category":"section"},{"location":"vizcon2/#","page":"vizcon2 talk","title":"vizcon2 talk","text":"Did use some GKS in the early times\nRolled my own: gms\nSwitched to OpenGL: gltools\nUses fixed function pipeline OpenGL standard\ngltools2 with FLTK gui included in WIAS simulation code   (we think about making this available to Julia)\nvtkfig","category":"page"},{"location":"vizcon2/#Why-vtk-?-1","page":"vizcon2 talk","title":"Why vtk ?","text":"","category":"section"},{"location":"vizcon2/#","page":"vizcon2 talk","title":"vizcon2 talk","text":"Fixed function  pipeline OpenGL deprecated\nDon't want to mess with shaders, Vulkan etc.\nVery few  intermediate level interfaces for GPU graphics available  \nthree.js but this sits in the browser  \nJosef Heinen's gr, but this also uses fixed function pipeline\nBig chance for Makie also outside of Julia\nVTK provides high level primitives for grid data based visualization   So why not... ?","category":"page"},{"location":"vizcon2/#[VTK](https://vtk.org)-1","page":"vizcon2 talk","title":"VTK","text":"","category":"section"},{"location":"vizcon2/#","page":"vizcon2 talk","title":"vizcon2 talk","text":"Started in 1993\nBSD license\nWell maintained, reasonable evolution with legacy edges\nModern OpenGL\nhopefully Vulkan   (fresh  discourse thread )   EDIT 2020-02-24: This seems to be on the way\nsmart pointers\nC++11 features\nFirst class citizen of CMake universe (both maintained by Kitware)\nLibrary behind Paraview, VisIt ...\nused by US labs ==> big  interest (IMHO) in keeping this going\n==> investment in learning appears to be  safe.","category":"page"},{"location":"vizcon2/#Some-cons-1","page":"vizcon2 talk","title":"Some cons","text":"","category":"section"},{"location":"vizcon2/#","page":"vizcon2 talk","title":"vizcon2 talk","text":"Lots of examples available, but steep learning curve nevertheless\nEvent loop based API hard to incorporate into simulation codes\nRather ugly plot attributes\nIt's YUGE","category":"page"},{"location":"vizcon2/#VTK-basic-structure-features-1","page":"vizcon2 talk","title":"VTK basic structure + features","text":"","category":"section"},{"location":"vizcon2/#","page":"vizcon2 talk","title":"vizcon2 talk","text":"Fill vtkDataSet with grid, point scalars etc.   (more or less 1:1 mapping with VTK files)\nCreate rendering pipelines by chaining various filters to extract isolines, apply colors ...\nsome similarity with Makie's lift \nParaview is the GUI for this","category":"page"},{"location":"vizcon2/#","page":"vizcon2 talk","title":"vizcon2 talk","text":"isoline_filter->SetInputConnection(transgeometry->GetOutputPort());","category":"page"},{"location":"vizcon2/#","page":"vizcon2 talk","title":"vizcon2 talk","text":"Create Actors which make things visible on the screen","category":"page"},{"location":"vizcon2/#[vtkfig](https://github.com/j-fu/vtkfig)-aka-fixed-rendering-pipeline-VTK-viewer-1","page":"vizcon2 talk","title":"vtkfig  aka fixed rendering pipeline VTK viewer","text":"","category":"section"},{"location":"vizcon2/#","page":"vizcon2 talk","title":"vizcon2 talk","text":"Several fixed but configurable pipelines for standard visualization tasks\nvtkfig::Figure\nvtkfig::ScalarView\nvtkfig::VectorView\nvtkfig::GridView\nvtkfig::XYPlot\nFigures can be added to a vtkfig::Frame\nEvent loop and rendering  in separate thread   At the cost of having all data copied ...\nInteractivity inherited from vtk\nFile output: images, video, vtk \nDuck typing based API for filling data structures   ==> easy integration into C++ code\nMemory management via  C++11 std::shared_ptr \nAdditional C API\nBuilds on Linux, MacOS, Unix Subsystem of Win10","category":"page"},{"location":"vizcon2/#[VTKView.jl](https://github.com/j_fu/VTKView.jl)-1","page":"vizcon2 talk","title":"VTKView.jl","text":"","category":"section"},{"location":"vizcon2/#","page":"vizcon2 talk","title":"vizcon2 talk","text":"Make vtkfig available from Julia\nIntegration via C API and ccall\nAttempt on a more \"julian\" API\nNo precompilation time ;-)","category":"page"},{"location":"vizcon2/#Plans-1","page":"vizcon2 talk","title":"Plans","text":"","category":"section"},{"location":"vizcon2/#vtkfig-1","page":"vizcon2 talk","title":"vtkfig","text":"","category":"section"},{"location":"vizcon2/#","page":"vizcon2 talk","title":"vizcon2 talk","text":"One thread per frame in multiple frame case\nNo time for GUI...\nTry out Paraview catalyst (send vtkDataset to Paraview)\nTry out higher order elements (vtk has some stuff for this)","category":"page"},{"location":"vizcon2/#VTKView.jl-1","page":"vizcon2 talk","title":"VTKView.jl","text":"","category":"section"},{"location":"vizcon2/#","page":"vizcon2 talk","title":"vizcon2 talk","text":"Map full API of vtkfig (still missing streamlines some state toggles)\njll \nbuilds with vtk-8.2.0 but only without cross compiling   jll works for linux-x86_64\nvtk-9.0.0 seems to support cross compiling   need to learn how to export cross compilation tools to client codes ...","category":"page"},{"location":"vizcon2/#Ideas-1","page":"vizcon2 talk","title":"Ideas","text":"","category":"section"},{"location":"vizcon2/#","page":"vizcon2 talk","title":"vizcon2 talk","text":"Backend for plot recipes ?","category":"page"},{"location":"api/#API-1","page":"API","title":"API","text":"","category":"section"},{"location":"api/#Types-and-Constants-1","page":"API","title":"Types and Constants","text":"","category":"section"},{"location":"api/#","page":"API","title":"API","text":"Modules = [VTKView]\nPages = [\"vtkfig.jl\",\"wrappers.jl\"]\nOrder = [:type]","category":"page"},{"location":"api/#VTKView.DataSet-Tuple{VTKView.DataSet}","page":"API","title":"VTKView.DataSet","text":"DataSet(this::VTKView.DataSet) -> VTKView.DataSet\n\n\nCreate a data set.\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.Frame-Tuple{VTKView.Frame}","page":"API","title":"VTKView.Frame","text":"Frame(this::VTKView.Frame) -> VTKView.Frame\n\n\nCreate Frame (corresponds to desktop window).\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.GridView-Tuple{VTKView.GridView}","page":"API","title":"VTKView.GridView","text":"GridView(this::VTKView.GridView) -> VTKView.GridView\n\n\nCreate a view for showing 2D or 3D grids.\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.ScalarView-Tuple{VTKView.ScalarView}","page":"API","title":"VTKView.ScalarView","text":"ScalarView(this::VTKView.ScalarView) -> VTKView.ScalarView\n\n\nCreate a view for showing 2D or 3D scalar data.\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.VectorView-Tuple{VTKView.VectorView}","page":"API","title":"VTKView.VectorView","text":"VectorView(this::VTKView.VectorView) -> VTKView.VectorView\n\n\nCreate a view for showing 2D or 3D vector data.\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.XYPlot-Tuple{VTKView.XYPlot}","page":"API","title":"VTKView.XYPlot","text":"XYPlot(this::VTKView.XYPlot) -> VTKView.XYPlot\n\n\nCreate a view for showing X-Y plots.\n\n\n\n\n\n","category":"method"},{"location":"api/#","page":"API","title":"API","text":"Modules = [VTKView]\nPages = [\"vtkfig.jl\",\"wrappers.jl\"]\nOrder = [:constant]","category":"page"},{"location":"api/#Methods-1","page":"API","title":"Methods","text":"","category":"section"},{"location":"api/#","page":"API","title":"API","text":"Modules = [VTKView]\nPages = [\"vtkfig.jl\",\"wrappers.jl\"]\nOrder = [:function]","category":"page"},{"location":"api/#Base.Multimedia.display-Tuple{VTKView.Frame}","page":"API","title":"Base.Multimedia.display","text":"display(frame::VTKView.Frame)\n\n\nDisplay frame content and continue.\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.addplot!-Tuple{VTKView.XYPlot,Array{Float64,1},Array{Float64,1}}","page":"API","title":"VTKView.addplot!","text":"addplot!(this::VTKView.XYPlot, X::Array{Float64,1}, Y::Array{Float64,1})\n\n\nAdd  one paticular plot (\"series\") to XYPlot object.\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.addview!-Tuple{VTKView.Frame,VTKView.GridView,Int64}","page":"API","title":"VTKView.addview!","text":"addview!(frame::VTKView.Frame, gridview::VTKView.GridView, pos::Int64)\n\n\nAdd view to frame.\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.addview!-Tuple{VTKView.Frame,VTKView.GridView}","page":"API","title":"VTKView.addview!","text":"addview!(frame::VTKView.Frame, gridview::VTKView.GridView)\n\n\nAdd view to frame.\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.addview!-Tuple{VTKView.Frame,VTKView.ScalarView,Int64}","page":"API","title":"VTKView.addview!","text":"addview!(frame::VTKView.Frame, scalarview::VTKView.ScalarView, pos::Int64)\n\n\nAdd view to frame.\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.addview!-Tuple{VTKView.Frame,VTKView.ScalarView}","page":"API","title":"VTKView.addview!","text":"addview!(frame::VTKView.Frame, scalarview::VTKView.ScalarView)\n\n\nAdd view to frame.\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.addview!-Tuple{VTKView.Frame,VTKView.VectorView,Int64}","page":"API","title":"VTKView.addview!","text":"addview!(frame::VTKView.Frame, vectorview::VTKView.VectorView, pos::Int64)\n\n\nAdd view to frame.\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.addview!-Tuple{VTKView.Frame,VTKView.VectorView}","page":"API","title":"VTKView.addview!","text":"addview!(frame::VTKView.Frame, vectorview::VTKView.VectorView)\n\n\nAdd view to frame.\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.addview!-Tuple{VTKView.Frame,VTKView.XYPlot,Int64}","page":"API","title":"VTKView.addview!","text":"addview!(frame::VTKView.Frame, xyplot::VTKView.XYPlot, pos::Int64)\n\n\nAdd view to frame.\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.addview!-Tuple{VTKView.Frame,VTKView.XYPlot}","page":"API","title":"VTKView.addview!","text":"addview!(frame::VTKView.Frame, xyplot::VTKView.XYPlot)\n\n\nAdd view to frame.\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.adjust_labels!-Tuple{VTKView.XYPlot,Bool}","page":"API","title":"VTKView.adjust_labels!","text":"adjust_labels!(this::VTKView.XYPlot, b::Bool)\n\n\nToggle automatic label adjustment.\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.axescolor!-Tuple{VTKView.XYPlot,Any,Any,Any}","page":"API","title":"VTKView.axescolor!","text":"axescolor!(this::VTKView.XYPlot, r::Any, g::Any, b::Any)\n\n\nColor of axes.\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.clear!-Tuple{VTKView.Frame}","page":"API","title":"VTKView.clear!","text":"clear!(frame::VTKView.Frame)\n\n\nClear frame content.\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.clear!-Tuple{VTKView.XYPlot}","page":"API","title":"VTKView.clear!","text":"clear!(this::VTKView.XYPlot)\n\n\nClear all data from plot.\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.data!-Tuple{VTKView.GridView,VTKView.DataSet}","page":"API","title":"VTKView.data!","text":"data!(this::VTKView.GridView, dataset::VTKView.DataSet)\n\n\nSet data to be shown to grid defined in dataset.\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.data!-Tuple{VTKView.ScalarView,VTKView.DataSet,Any}","page":"API","title":"VTKView.data!","text":"data!(this::VTKView.ScalarView, dataset::VTKView.DataSet, name::Any)\n\n\nSet data to be shown to point scalar name in dataset.\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.data!-Tuple{VTKView.VectorView,VTKView.DataSet,Any}","page":"API","title":"VTKView.data!","text":"data!(this::VTKView.VectorView, dataset::VTKView.DataSet, name::Any)\n\n\nSet data to be shown to point scalar name in dataset.\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.frametitle!-Tuple{VTKView.Frame,Any}","page":"API","title":"VTKView.frametitle!","text":"frametitle!(frame::VTKView.Frame, title::Any)\n\n\nSet title in frame\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.gridcolor!-Tuple{VTKView.XYPlot,Any,Any,Any}","page":"API","title":"VTKView.gridcolor!","text":"gridcolor!(this::VTKView.XYPlot, r::Any, g::Any, b::Any)\n\n\nColor of background grid.\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.interact-Tuple{VTKView.Frame}","page":"API","title":"VTKView.interact","text":"interact(frame::VTKView.Frame)\n\n\nDisplay frame content and enter interaction mode.\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.isolevels!-Tuple{VTKView.ScalarView,Array{Float64,1}}","page":"API","title":"VTKView.isolevels!","text":"isolevels!(this::VTKView.ScalarView, V::Array{Float64,1})\n\n\nSet isolevels for isocontour and isosurface plot.\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.layout!-Tuple{VTKView.Frame,Any,Any}","page":"API","title":"VTKView.layout!","text":"layout!(frame::VTKView.Frame, nrows::Any, ncol::Any)\n\n\nSet frame layout.\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.legendposition!-Tuple{VTKView.XYPlot,Any,Any}","page":"API","title":"VTKView.legendposition!","text":"legendposition!(this::VTKView.XYPlot, x::Any, y::Any)\n\n\nSet legend position.\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.legendsize!-Tuple{VTKView.XYPlot,Any,Any}","page":"API","title":"VTKView.legendsize!","text":"legendsize!(this::VTKView.XYPlot, w::Any, h::Any)\n\n\nSed legend size.\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.linewidth!-Tuple{VTKView.XYPlot,Any}","page":"API","title":"VTKView.linewidth!","text":"linewidth!(this::VTKView.XYPlot, w::Any)\n\n\nLinewidth of next plot.\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.markersize!-Tuple{VTKView.XYPlot,Any}","page":"API","title":"VTKView.markersize!","text":"markersize!(this::VTKView.XYPlot, s::Any)\n\n\nMarker size of next plot.\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.numberofxlabels!-Tuple{VTKView.XYPlot,Any}","page":"API","title":"VTKView.numberofxlabels!","text":"numberofxlabels!(this::VTKView.XYPlot, n::Any)\n\n\nNumber of labels on X axis.\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.numberofylabels!-Tuple{VTKView.XYPlot,Any}","page":"API","title":"VTKView.numberofylabels!","text":"numberofylabels!(this::VTKView.XYPlot, n::Any)\n\n\nNumber of labels on Y axis.\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.plotcolor!-Tuple{VTKView.XYPlot,Any,Any,Any}","page":"API","title":"VTKView.plotcolor!","text":"plotcolor!(this::VTKView.XYPlot, r::Any, g::Any, b::Any)\n\n\nColor of next plot.\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.plotlegend!-Tuple{VTKView.XYPlot,Any}","page":"API","title":"VTKView.plotlegend!","text":"plotlegend!(this::VTKView.XYPlot, legend::Any)\n\n\nLegend of next plot.\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.plotlinetype!-Tuple{VTKView.XYPlot,Any}","page":"API","title":"VTKView.plotlinetype!","text":"plotlinetype!(this::VTKView.XYPlot, ltype::Any)\n\n\nLine type of next plot.\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.plotmarkertype!-Tuple{VTKView.XYPlot,Any}","page":"API","title":"VTKView.plotmarkertype!","text":"plotmarkertype!(this::VTKView.XYPlot, mtype::Any)\n\n\nMarker type of next plot.\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.pointscalar!-Tuple{VTKView.DataSet,Array{Float64,1},Any}","page":"API","title":"VTKView.pointscalar!","text":"pointscalar!(this::VTKView.DataSet, X::Array{Float64,1}, name::Any)\n\n\nAdd piece wise linear function with identifier name to dataset.\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.pointvector!-Tuple{VTKView.DataSet,Array{Float64,2},Any}","page":"API","title":"VTKView.pointvector!","text":"pointvector!(this::VTKView.DataSet, UVW::Array{Float64,2}, name::Any)\n\n\nAdd piece wise linear function with identifier name to dataset.\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.position!-Tuple{VTKView.Frame,Any,Any}","page":"API","title":"VTKView.position!","text":"position!(frame::VTKView.Frame, x::Any, y::Any)\n\n\nSet frame position on screen.\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.rectilineargrid!-Tuple{VTKView.DataSet,Array{Float64,1},Array{Float64,1},Array{Float64,1}}","page":"API","title":"VTKView.rectilineargrid!","text":"rectilineargrid!(this::VTKView.DataSet, X::Array{Float64,1}, Y::Array{Float64,1}, Z::Array{Float64,1})\n\n\nCreate 3D rectilinear grid in dataset.\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.rectilineargrid!-Tuple{VTKView.DataSet,Array{Float64,1},Array{Float64,1}}","page":"API","title":"VTKView.rectilineargrid!","text":"rectilineargrid!(this::VTKView.DataSet, X::Array{Float64,1}, Y::Array{Float64,1})\n\n\nCreate 2D rectilinear grid in dataset.\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.remove!-Tuple{VTKView.Frame,VTKView.GridView}","page":"API","title":"VTKView.remove!","text":"remove!(frame::VTKView.Frame, gridview::VTKView.GridView)\n\n\nRemove  view from frame.\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.remove!-Tuple{VTKView.Frame,VTKView.ScalarView}","page":"API","title":"VTKView.remove!","text":"remove!(frame::VTKView.Frame, scalarview::VTKView.ScalarView)\n\n\nRemove  view from frame.\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.remove!-Tuple{VTKView.Frame,VTKView.VectorView}","page":"API","title":"VTKView.remove!","text":"remove!(frame::VTKView.Frame, vectorview::VTKView.VectorView)\n\n\nRemove  view from frame.\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.remove!-Tuple{VTKView.Frame,VTKView.XYPlot}","page":"API","title":"VTKView.remove!","text":"remove!(frame::VTKView.Frame, xyplot::VTKView.XYPlot)\n\n\nRemove  view from frame.\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.show_grid!-Tuple{VTKView.XYPlot,Bool}","page":"API","title":"VTKView.show_grid!","text":"show_grid!(this::VTKView.XYPlot, b::Bool)\n\n\nToggle display of background grid in plot.\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.show_isosurfaces!-Tuple{VTKView.ScalarView,Bool}","page":"API","title":"VTKView.show_isosurfaces!","text":"show_isosurfaces!(this::VTKView.ScalarView, b::Bool)\n\n\nToggle display of isosurfaces in 3D plot.\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.show_legend!-Tuple{VTKView.XYPlot,Bool}","page":"API","title":"VTKView.show_legend!","text":"show_legend!(this::VTKView.XYPlot, b::Bool)\n\n\nToggle display of legend in plot.\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.simplexgrid!-Tuple{VTKView.DataSet,Array{Float64,2},Array{Int32,2}}","page":"API","title":"VTKView.simplexgrid!","text":"simplexgrid!(this::VTKView.DataSet, Points::Array{Float64,2}, Cells::Array{Int32,2})\n\n\nCreate simplex grid in dataset.\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.size!-Tuple{VTKView.Frame,Any,Any}","page":"API","title":"VTKView.size!","text":"size!(frame::VTKView.Frame, x::Any, y::Any)\n\n\nSet frame size.\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.startvideo-Tuple{VTKView.Frame,Any}","page":"API","title":"VTKView.startvideo","text":"startvideo(frame::VTKView.Frame, fname::Any)\n\n\nStart video recording.\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.stopvideo-Tuple{VTKView.Frame}","page":"API","title":"VTKView.stopvideo","text":"stopvideo(frame::VTKView.Frame)\n\n\nStop video recording\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.title!-Tuple{VTKView.XYPlot,Any}","page":"API","title":"VTKView.title!","text":"title!(this::VTKView.XYPlot, title::Any)\n\n\nSet plot title.\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.windowtitle!-Tuple{VTKView.Frame,Any}","page":"API","title":"VTKView.windowtitle!","text":"windowtitle!(frame::VTKView.Frame, title::Any)\n\n\nSet title of window corresponding to frame\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.writepng-Tuple{VTKView.Frame,Any}","page":"API","title":"VTKView.writepng","text":"writepng(frame::VTKView.Frame, fname::Any)\n\n\nWrite frame content to png file.\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.writevtk-Tuple{VTKView.DataSet,Any}","page":"API","title":"VTKView.writevtk","text":"writevtk(this::VTKView.DataSet, fname::Any; ftype)\n\n\nWrite data set content to vtk file.\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.xrange!-Tuple{VTKView.XYPlot,Any,Any}","page":"API","title":"VTKView.xrange!","text":"xrange!(this::VTKView.XYPlot, x0::Any, x1::Any)\n\n\nRange of X coordinates.\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.xtitle!-Tuple{VTKView.XYPlot,Any}","page":"API","title":"VTKView.xtitle!","text":"xtitle!(this::VTKView.XYPlot, title::Any)\n\n\nX Axis title.\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.yrange!-Tuple{VTKView.XYPlot,Any,Any}","page":"API","title":"VTKView.yrange!","text":"yrange!(this::VTKView.XYPlot, y0::Any, y1::Any)\n\n\nRange of Y coordinates.\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.ytitle!-Tuple{VTKView.XYPlot,Any}","page":"API","title":"VTKView.ytitle!","text":"ytitle!(this::VTKView.XYPlot, title::Any)\n\n\nY Axis title.\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.boundarygrid!-Tuple{VTKView.DataSet,Array{Int32,2}}","page":"API","title":"VTKView.boundarygrid!","text":"boundarygrid!(this::VTKView.DataSet, Cells::Array{Int32,2})\n\n\nCreate simplex grid boundary consisting of codimension 1 cells in dataset \n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.boundarymarker!-Tuple{VTKView.DataSet,Array{Int32,1}}","page":"API","title":"VTKView.boundarymarker!","text":"boundarymarker!(this::VTKView.DataSet, M::Array{Int32,1})\n\n\nAdd boundary cell region indicator\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.cellmarker!-Tuple{VTKView.DataSet,Array{T,1} where T}","page":"API","title":"VTKView.cellmarker!","text":"cellmarker!(this::VTKView.DataSet, M::Array{T,1} where T)\n\n\nAdd boundary cell region indicator\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.unmap!-Tuple{VTKView.Frame}","page":"API","title":"VTKView.unmap!","text":"unmap!(this::VTKView.Frame)\n\n\nUnmap frame window\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.StaticFrame-Tuple{}","page":"API","title":"VTKView.StaticFrame","text":"StaticFrame()\n\n\nReturn static frame, and create it if it doesnt exist\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.delaunay-Tuple{Any}","page":"API","title":"VTKView.delaunay","text":"delaunay(inpoints)\n\n\nCreate Delaunay triangulation from set of points\n\n\n\n\n\n","category":"method"},{"location":"api/#VTKView.unmap_static_frame-Tuple{}","page":"API","title":"VTKView.unmap_static_frame","text":"unmap_static_frame()\n\n\nUnmap static frame\n\n\n\n\n\n","category":"method"},{"location":"examples/#Examples-1","page":"Examples","title":"Examples","text":"","category":"section"},{"location":"examples/#","page":"Examples","title":"Examples","text":"The source code of the examples is here.","category":"page"},{"location":"examples/#","page":"Examples","title":"Examples","text":"Modules = [VTKView.Examples]\nPages = [\"Examples/Examples.jl\"]","category":"page"},{"location":"examples/#VTKView.Examples.example_triangulate_domain-Tuple{}","page":"Examples","title":"VTKView.Examples.example_triangulate_domain","text":"example_triangulate_domain(; Triangulate)\n\n\nUse Triangulate.jl for creation of domain triangulation.  Pass the Triangulate module as the value of the keyword parameter\n\n\n\n\n\n","category":"method"},{"location":"examples/#VTKView.Examples.example_triangulate_domain_regions-Tuple{}","page":"Examples","title":"VTKView.Examples.example_triangulate_domain_regions","text":"example_triangulate_domain_regions(; Triangulate, minangle)\n\n\nUse Triangulate.jl for creation of domain triangulation with cell and boundary markers. Pass the Triangulate module as the value of the keyword parameter\n\n\n\n\n\n","category":"method"},{"location":"examples/#VTKView.Examples.multifig-Tuple{}","page":"Examples","title":"VTKView.Examples.multifig","text":"multifig(; tend, n)\n\n\nDemonstrate multiple views in one frame\n\n\n\n\n\n","category":"method"},{"location":"examples/#VTKView.Examples.rectgrid2d-Tuple{}","page":"Examples","title":"VTKView.Examples.rectgrid2d","text":"rectgrid2d(; tend, n)\n\n\nPlot 2D rectangular grid\n\n\n\n\n\n","category":"method"},{"location":"examples/#VTKView.Examples.rectgrid3d-Tuple{}","page":"Examples","title":"VTKView.Examples.rectgrid3d","text":"rectgrid3d(; tend, n)\n\n\nPlot 3D rectilinear grid\n\n\n\n\n\n","category":"method"},{"location":"examples/#VTKView.Examples.rectquiver2d-Tuple{}","page":"Examples","title":"VTKView.Examples.rectquiver2d","text":"rectquiver2d(; tend, n)\n\n\nPlot scalar + vector function on rectilinear grid\n\n\n\n\n\n","category":"method"},{"location":"examples/#VTKView.Examples.rectquiver3d-Tuple{}","page":"Examples","title":"VTKView.Examples.rectquiver3d","text":"rectquiver3d(; tend, n)\n\n\nPlot scalar + vector function on 3D rectilinear grid\n\n\n\n\n\n","category":"method"},{"location":"examples/#VTKView.Examples.rectscalar2d-Tuple{}","page":"Examples","title":"VTKView.Examples.rectscalar2d","text":"rectscalar2d(; tend, n)\n\n\nPlot scalar function on rectilinear grid\n\n\n\n\n\n","category":"method"},{"location":"examples/#VTKView.Examples.rectscalar3d-Tuple{}","page":"Examples","title":"VTKView.Examples.rectscalar3d","text":"rectscalar3d(; n, tend)\n\n\nPlot scalar function on 3D rectilinear grid\n\n\n\n\n\n","category":"method"},{"location":"examples/#VTKView.Examples.simplexgrid2d-Tuple{}","page":"Examples","title":"VTKView.Examples.simplexgrid2d","text":"simplexgrid2d(; tend, n)\n\n\nPlot triangular grid\n\n\n\n\n\n","category":"method"},{"location":"examples/#VTKView.Examples.simplexgrid3d-Tuple{}","page":"Examples","title":"VTKView.Examples.simplexgrid3d","text":"simplexgrid3d(; tend, n)\n\n\nPlot tetrahedral grid.\n\n\n\n\n\n","category":"method"},{"location":"examples/#VTKView.Examples.simplexquiver2d-Tuple{}","page":"Examples","title":"VTKView.Examples.simplexquiver2d","text":"simplexquiver2d(; tend, n)\n\n\nPlot scalar + vector function on rectilinear grid\n\n\n\n\n\n","category":"method"},{"location":"examples/#VTKView.Examples.simplexquiver3d-Tuple{}","page":"Examples","title":"VTKView.Examples.simplexquiver3d","text":"simplexquiver3d(; tend, n)\n\n\nPlot scalar + vector function on rectilinear grid\n\n\n\n\n\n","category":"method"},{"location":"examples/#VTKView.Examples.simplexscalar2d-Tuple{}","page":"Examples","title":"VTKView.Examples.simplexscalar2d","text":"simplexscalar2d(; tend, n)\n\n\nPlot scalar function on triangular grid\n\n\n\n\n\n","category":"method"},{"location":"examples/#VTKView.Examples.simplexscalar3d-Tuple{}","page":"Examples","title":"VTKView.Examples.simplexscalar3d","text":"simplexscalar3d(; tend, n)\n\n\nPlot scalar function on tetrahedral grid.\n\n\n\n\n\n","category":"method"}]
}
