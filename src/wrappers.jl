#
# Wrapper functions
# 


# Variable holding static frame
_static_frame=nothing

"""
$(SIGNATURES)
Return static frame, and create it if it doesnt exist
"""
function StaticFrame()
    global _static_frame
    if _static_frame==nothing
        _static_frame=Frame()
        windowtitle!(_static_frame,"VTKView.jl")
    end
    return _static_frame
end

"""
$(SIGNATURES)
Destroy static frame
"""
function destroy_static_frame()
    global _static_frame
    if _static_frame!=nothing
        destruct!(_static_frame)
    end
    _static_frame=nothing
end

"""
$(SIGNATURES)
Create Delaunay triangulation from set of points
"""
function delaunay(inpoints)
    pts=Array{Cdouble,2}(inpoints)
    sxgrid=vtkfigSimplexGrid()
    delaunay!(sxgrid,pts)
    points = convert(Array{Cdouble,2}, Base.unsafe_wrap(Array, sxgrid.points, (Int(sxgrid.dim),Int(sxgrid.npoints)), own=true))
    cells =  convert(Array{Cint,2}, Base.unsafe_wrap(Array, sxgrid.cells, (Int(sxgrid.dim)+1,Int(sxgrid.ncells)), own=true))
    return (points,cells)
end

