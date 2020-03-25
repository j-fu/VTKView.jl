module Examples
using DocStringExtensions
using ForwardDiff
using VTKView
using Printf

"""
$(SIGNATURES)

Plot 2D rectangular grid
"""
function rectgrid2d(;tend=5,n=20)
    frame=VTKView.StaticFrame()
    clear!(frame)
    frametitle!(frame,"2D rectilinear grid")
    X=collect(-1.0:1.0/n:1.0)
    N=length(X)
    dataset=VTKView.DataSet()
    rectilineargrid!(dataset,X,X)
    gridview=VTKView.GridView()
    data!(gridview,dataset)
    addview!(frame,gridview)
    display(frame)
end

"""
$(SIGNATURES)

Plot scalar function on rectilinear grid
"""
function rectscalar2d(;tend=5,n=50)
    frame=VTKView.StaticFrame()
    clear!(frame)
    frametitle!(frame,"Scalar on rectilinear grid")
    X=collect(0:1.0/n:1.0)
    Y=collect(0:1.0/n:1.0)
    Z=zeros(Float64,length(X),length(Y))
    F(x,y,t)=exp(-(x*x+y*y))*sin(t+9.0*x)*cos(11.0*y-2.0*t)
    clear!(frame)
    dataset=VTKView.DataSet()
    scalarview=VTKView.ScalarView()
    layout!(frame,1,1)
    size!(frame,500,500)
    rectilineargrid!(dataset,X,Y) 
    pointscalar!(dataset,vec(Z),"V")
    data!(scalarview,dataset,"V")
    addview!(frame,scalarview,1)
    for t in 0:0.1:tend
        for i=1:length(X)
            for j=1:length(Y)
                Z[i,j] = F(X[i],Y[j],t)
            end
        end
        pointscalar!(dataset,vec(Z),"V")
        display(frame)
    end
end


"""
$(SIGNATURES)

Plot scalar + vector function on rectilinear grid
"""
function rectquiver2d(;tend=10,n=50)
    frame=VTKView.StaticFrame()
    clear!(frame)
    frametitle!(frame,"Quiver on rectilinear grid")
    X=collect(0:1.0/n:1.0)
    Y=collect(0:1.0/n:1.5)
    Z=zeros(Float64,length(X),length(Y))
    F0(x,y,t)=exp(-(x*x+y*y))*sin(t/2+3.0*x)*cos(4.0*y-t/3)
    F(X)=F0(X...)

    GradZ=zeros(Float64,2,length(X),length(Y))

    clear!(frame)
    layout!(frame,1,1)
    size!(frame,500,500)


    dataset=VTKView.DataSet()
    rectilineargrid!(dataset,X,Y) 
    pointscalar!(dataset,vec(Z),"V")
    pointvector!(dataset,reshape(GradZ,2,length(X)*length(Y)),"GradV")


    scalarview=VTKView.ScalarView()
    data!(scalarview,dataset,"V")

    
    vectorview=VTKView.VectorView()
    data!(vectorview,dataset,"GradV")
    quiver!(vectorview,10,10)

    addview!(frame,scalarview,1)
    addview!(frame,vectorview,1)
    for t in 0:0.1:tend
        for i=1:length(X)
            for j=1:length(Y)
                Z[i,j] = F0(X[i],Y[j],t)
                GradZ[:,i,j]=ForwardDiff.gradient(F,[X[i],Y[j],t])[1:2]
            end
        end
        pointvector!(dataset,reshape(GradZ,2,length(X)*length(Y)),"GradV")
        pointscalar!(dataset,vec(Z),"V")
        display(frame)
    end
end





"""
$(SIGNATURES)

Plot triangular grid
"""
function simplexgrid2d(;tend=5,n=20)
    frame=VTKView.StaticFrame()
    clear!(frame)
    frametitle!(frame,"Triangular grid")
    raster=100
    npt=n*n
    inpoints=hcat(unique([ Cdouble[rand(1:raster)/raster, rand(1:raster)/raster] for i in 1:npt])...)
    (points,cells)=VTKView.delaunay(inpoints)
    dataset=VTKView.DataSet()
    simplexgrid!(dataset,points,cells)
    gridview=VTKView.GridView()
    data!(gridview,dataset)
    addview!(frame,gridview)
    display(frame)
end


"""
$(SIGNATURES)

Plot scalar function on triangular grid
"""
function simplexscalar2d(;tend=5,n=50)
    frame=VTKView.StaticFrame()
    clear!(frame)
    frametitle!(frame,"Scalar on triangular grid")
    raster=100
    npt=n*n
    inpoints=hcat(unique([ Cdouble[rand(1:raster)/raster, rand(1:raster)/raster] for i in 1:npt])...)
    (points,cells)=VTKView.delaunay(inpoints)

    npt=size(points,2)
    Z=zeros(Float64,npt)


    F(x,y,t)=exp(-(x*x+y*y))*sin(t+9.0*x)*cos(11.0*y-2.0*t)
    
    dataset=VTKView.DataSet()
    simplexgrid!(dataset,points,cells)

    scalarview=VTKView.ScalarView()
    layout!(frame,1,1)
    size!(frame,500,500)
    pointscalar!(dataset,Z,"V")
    data!(scalarview,dataset,"V")
    addview!(frame,scalarview,1)
    
    for t in 0:0.1:tend
        for i=1:npt
            Z[i]=F(points[:,i]..., t)
        end
        pointscalar!(dataset,vec(Z),"V")
        display(frame)
    end
end



"""
$(SIGNATURES)

Plot scalar + vector function on rectilinear grid
"""
function simplexquiver2d(;tend=10,n=50)
    frame=VTKView.StaticFrame()
    clear!(frame)
    frametitle!(frame,"Quiver on triangular grid")
    raster=100
    npt=n*n
    inpoints=hcat(unique([ Cdouble[rand(1:raster)/raster, rand(1:raster)/raster] for i in 1:npt])...)
    (points,cells)=VTKView.delaunay(inpoints)

    npt=size(points,2)
    Z=zeros(Float64,npt)
    F0(x,y,t)=exp(-(x*x+y*y))*sin(t/2+3.0*x)*cos(4.0*y-t/3)
    F(X)=F0(X...)

    GradZ=zeros(Float64,2,npt)

    clear!(frame)
    layout!(frame,1,1)
    size!(frame,500,500)


    dataset=VTKView.DataSet()
    simplexgrid!(dataset,points,cells)
    pointscalar!(dataset,vec(Z),"V")
    pointvector!(dataset,GradZ,"GradV")


    scalarview=VTKView.ScalarView()
    data!(scalarview,dataset,"V")

    
    vectorview=VTKView.VectorView()
    data!(vectorview,dataset,"GradV")
    quiver!(vectorview,10,10)

    addview!(frame,scalarview,1)
    addview!(frame,vectorview,1)
    for t in 0:0.1:tend
        for i=1:npt
            Z[i]=F0(points[:,i]..., t)
            GradZ[:,i]=ForwardDiff.gradient(F,[points[1,i],points[2,i],t])[1:2]
        end
        pointvector!(dataset,GradZ,"GradV")
        pointscalar!(dataset,vec(Z),"V")
        display(frame)
    end
end



"""
$(SIGNATURES)

Plot 3D rectilinear grid
"""
function rectgrid3d(;tend=5,n=50)
    frame=VTKView.StaticFrame()
    frametitle!(frame,"3D rectilinear grid")
    clear!(frame)
    X=collect(-1.0:1.0/n:1.0)
    N=length(X)
    dataset=VTKView.DataSet()
    rectilineargrid!(dataset,X,X,X)
    gridview=VTKView.GridView()
    data!(gridview,dataset)
    addview!(frame,gridview)
    display(frame)
end

"""
$(SIGNATURES)

Plot scalar function on 3D rectilinear grid
"""
function rectscalar3d(;n=50,tend=5)
    frame=VTKView.StaticFrame()
    frametitle!(frame,"Scalar on 3D rectilinear grid")
    F(x,y,z,t,a)=exp(-10*((x-sin(a[1]*t))^2+(y-sin(a[2]*t))^2+(z-sin(a[3]*t))^2))
    F(x,y,z,t)=F(x,y,z,t,(-1.0,1.0,1.0))+F(x,y,z,t,(1.0,-1.0,1.0))+F(x,y,z,t,(1.0,1.0,-1.0))
    X=collect(-1.0:1.0/n:1.0)
    N=length(X)
    V=[F(X[i],X[j],X[k],0) for i=1:N,j=1:N,k=1:N]
    clear!(frame)
    dataset=VTKView.DataSet()
    scalarview=VTKView.ScalarView()
    size!(frame,500,500)
    rectilineargrid!(dataset,X,X,X) 
    pointscalar!(dataset,vec(V),"V")
    data!(scalarview,dataset,"V")
    show_isosurfaces!(scalarview,true)
    isolevels!(scalarview,collect(0:0.25:1))
    addview!(frame,scalarview)

    for t in 0:0.1:tend
        for i=1:N,j=1:N,k=1:N
            V[i,j,k]=F(X[i],X[j],X[k],t)
        end
        pointscalar!(dataset,vec(V),"V")
        display(frame)
    end
end


"""
$(SIGNATURES)

Plot scalar + vector function on 3D rectilinear grid
"""
function rectquiver3d(;tend=10,n=20)
    frame=VTKView.StaticFrame()
    clear!(frame)
    frametitle!(frame,"Quiver on rectilinear grid")
    X=collect(0:1.0/n:1.0)
    
    Z=zeros(Float64,length(X),length(X),length(X))
    F0(x,y,z,t)=exp(-(x*x+y*y))*sin(t/2+3.0*x)*cos(4.0*y-t/3)+z
    F(X)=F0(X...)
    
    GradZ=zeros(Float64,3,length(X),length(X),length(X))
    
    clear!(frame)
    layout!(frame,1,1)
    size!(frame,500,500)


    dataset=VTKView.DataSet()
    rectilineargrid!(dataset,X,X,X) 
    pointscalar!(dataset,vec(Z),"V")
    pointvector!(dataset,reshape(GradZ,3,length(X)^3),"GradV")


    scalarview=VTKView.ScalarView()
    data!(scalarview,dataset,"V")

    
    vectorview=VTKView.VectorView()
    data!(vectorview,dataset,"GradV")
    quiver!(vectorview,10,10,10)

    addview!(frame,scalarview,1)
    addview!(frame,vectorview,1)
    for t in 0:0.1:tend
        for i=1:length(X)
            for j=1:length(X)
                for k=1:length(X)
                    Z[i,j,k] = F0(X[i],X[j],X[k],t)
                    GradZ[:,i,j,k]=ForwardDiff.gradient(F,[X[i],X[j],X[k],t])[1:3]
                end
            end
        end
        pointvector!(dataset,reshape(GradZ,3,length(X)^3),"GradV")
        pointscalar!(dataset,vec(Z),"V")
        display(frame)
    end
end



"""
$(SIGNATURES)
Plot tetrahedral grid.
"""
function simplexgrid3d(;tend=5,n=20)
    frame=VTKView.StaticFrame()
    clear!(frame)
    frametitle!(frame,"Tetrahedral grid")
    raster=100
    npt=n*n*n
    inpoints=hcat(unique([ Cdouble[rand(1:raster)/raster, rand(1:raster)/raster,rand(1:raster)/raster] for i in 1:npt])...)
    (points,cells)=VTKView.delaunay(inpoints)
    dataset=VTKView.DataSet()
    simplexgrid!(dataset,points,cells)
    gridview=VTKView.GridView()
    data!(gridview,dataset)
    addview!(frame,gridview)
    display(frame)
end



"""
$(SIGNATURES)
Plot scalar function on tetrahedral grid.
"""
function simplexscalar3d(;tend=5,n=20)
    frame=VTKView.StaticFrame()
    clear!(frame)
    frametitle!(frame,"Scalar on tetrahedral grid")
    raster=100
    npt=n*n*n
    inpoints=hcat(unique([ Cdouble[rand(1:raster)/raster, rand(1:raster)/raster, rand(1:raster)/raster] for i in 1:npt])...)
    (points,cells)=VTKView.delaunay(inpoints)

    npt=size(points,2)
    Z=zeros(Float64,npt)


    F(x,y,z,t)=sin((10+sin(t))*x-t)*cos(10y-t)*sin(3z-2t)
    
    dataset=VTKView.DataSet()
    simplexgrid!(dataset,points,cells)

    scalarview=VTKView.ScalarView()
    layout!(frame,1,1)
    size!(frame,500,500)
    pointscalar!(dataset,Z,"V")
    data!(scalarview,dataset,"V")
    addview!(frame,scalarview,1)
    show_isosurfaces!(scalarview,true)
    isolevels!(scalarview,[0.1,0.9])
    
    for t in 0:0.1:tend
        for i=1:npt
            Z[i]=F(points[:,i]..., t)
        end
        pointscalar!(dataset,vec(Z),"V")
        display(frame)
    end
end


"""
$(SIGNATURES)

Plot scalar + vector function on rectilinear grid
"""
function simplexquiver3d(;tend=10,n=20)
    frame=VTKView.StaticFrame()
    clear!(frame)
    frametitle!(frame,"Quiver on tetrahedral grid")
    raster=100
    npt=n*n*n
    inpoints=hcat(unique([ Cdouble[rand(1:raster)/raster, rand(1:raster)/raster, rand(1:raster)/raster] for i in 1:npt])...)
    (points,cells)=VTKView.delaunay(inpoints)

    npt=size(points,2)
    Z=zeros(Float64,npt)
    F0(x,y,z,t)=exp(-(x*x+y*y))*sin(t/2+3.0*x)*cos(4.0*y-t/3)+z
    F(X)=F0(X...)

    GradZ=zeros(Float64,3,npt)

    clear!(frame)
    layout!(frame,1,1)
    size!(frame,500,500)


    dataset=VTKView.DataSet()
    simplexgrid!(dataset,points,cells)
    pointscalar!(dataset,vec(Z),"V")
    pointvector!(dataset,GradZ,"GradV")


    scalarview=VTKView.ScalarView()
    data!(scalarview,dataset,"V")

    
    vectorview=VTKView.VectorView()
    data!(vectorview,dataset,"GradV")
    quiver!(vectorview,5,5,5)

    addview!(frame,scalarview,1)
    addview!(frame,vectorview,1)
    for t in 0:0.1:tend
        for i=1:npt
            Z[i]=F0(points[:,i]..., t)
            GradZ[:,i]=ForwardDiff.gradient(F,[points[1,i],points[2,i],points[3,i],t])[1:3]
        end
        pointvector!(dataset,GradZ,"GradV")
        pointscalar!(dataset,vec(Z),"V")
        display(frame)
    end
end

"""
$(SIGNATURES)

Demonstrate multiple views in one frame
"""
function multifig(;tend=5,n=50)
    frame=VTKView.StaticFrame()

    clear!(frame)
    
    frametitle!(frame,"Scalar function + values on sections")
    F(x,y,t)=exp(-(x*x+y*y))*sin(t+9.0*x)*cos(11.0*y-2.0*t)
    X=collect(0:1.0/n:1.0)
    Y=collect(0:1.0/n:1.0)
    h=0.01
    X=collect(0:h:1.0)
    Y=collect(0:h:1.2)
    Z=zeros(Float64,length(X),length(Y))
    dataset=VTKView.DataSet()
    scalarview=VTKView.ScalarView()
    layout!(frame,2,1)
    size!(frame,1200,500)
    rectilineargrid!(dataset,X,Y) 

    pointscalar!(dataset,vec(Z),"V")
    data!(scalarview,dataset,"V")
    addview!(frame,scalarview,1)

    plot=VTKView.XYPlot()
    addview!(frame,plot,2)
    
    for t in 0:0.1:tend
        for i=1:length(X)
            for j=1:length(Y)
                Z[i,j] = F(X[i],Y[j],t)
            end
        end
        pointscalar!(dataset,vec(Z),"V")
        clear!(plot)
        plotlegend!(plot,"j=1")
        plotcolor!(plot,1,0,0)
        addplot!(plot,X,Z[:,1])

        plotcolor!(plot,0,0,1)
        plotlegend!(plot,"i=1")
        addplot!(plot,Y,Z[1,:])

        display(frame)
    end
    writepng(frame,"multifig.png")
    writevtk(dataset,"multifig.vtk")
end

# ### Run all standard examples
function all()
    rectgrid2d()
    rectscalar2d()
    simplexgrid2d()
    simplexscalar2d()
    rectgrid3d()
    rectscalar3d()
    simplexgrid3d()
    simplexscalar3d()
    multifig()
end


# ### Examples with triangulate
"""
$(SIGNATURES)

Use Triangulate.jl for creation of domain triangulation. 
Pass the `Triangulate` module as the value of the keyword parameter
"""
function example_triangulate_domain(;Triangulate=nothing)
    Triangulate==nothing && return

    # generate grid
    triin=Triangulate.TriangulateIO()
    triin.pointlist=Matrix{Cdouble}([-1 -1; 0 -1; 0 0; 1 0; 1 1; -1 1]')
    triin.segmentlist=Matrix{Cint}([1 2 ; 2 3 ; 3 4 ; 4 5 ; 5 6 ; 6 1 ]')
    triin.segmentmarkerlist=Vector{Cint}([1, 2, 2, 1, 1, 1])
    (triout, vorout)=Triangulate.triangulate("pALVa0.1", triin)
    frame=VTKView.StaticFrame()
    clear!(frame)
    frametitle!(frame,"grid")
    dataset=VTKView.DataSet()
    VTKView.simplexgrid!(dataset,triout.pointlist,triout.trianglelist)
    gridview=VTKView.GridView()
    VTKView.data!(gridview,dataset)
    VTKView.addview!(frame,gridview)
    display(frame)
    
end



"""
$(SIGNATURES)

Use Triangulate.jl for creation of domain triangulation with cell and boundary markers.
Pass the `Triangulate` module as the value of the keyword parameter
"""
function example_triangulate_domain_regions(;Triangulate=nothing,minangle=20)
    Triangulate==nothing && return

    triin=Triangulate.TriangulateIO()
    triin.pointlist=Matrix{Cdouble}([0.0 0.0 ;0.5 0.0; 1.0 0.0 ; 1.0  1.0 ; 0.6 0.6; 0.0 1.0]')
    triin.segmentlist=Matrix{Cint}([1 2 ; 2 3 ;3 4 ; 4 5 ; 5 6 ; 6 1 ; 2 5]')
    triin.segmentmarkerlist=Vector{Int32}([1, 2, 3, 4, 5, 6, 7])
    triin.regionlist=Matrix{Cdouble}([0.2 0.8; 0.2 0.2; 1 2 ; 0.01 0.05])
    angle=@sprintf("%.15f",minangle)
    (triout, vorout)=Triangulate.triangulate("paAq$(angle)Q", triin)
    frame=VTKView.StaticFrame()
    clear!(frame)
    dataset=VTKView.DataSet()
    VTKView.simplexgrid!(dataset,triout.pointlist,triout.trianglelist)
    VTKView.boundarygrid!(dataset,triout.segmentlist)
    VTKView.boundarymarker!(dataset,triout.segmentmarkerlist)
    VTKView.cellmarker!(dataset,vec(triout.triangleattributelist))
    gridview=VTKView.GridView()
    VTKView.data!(gridview,dataset)
    VTKView.addview!(frame,gridview)
    display(frame)
end



end
