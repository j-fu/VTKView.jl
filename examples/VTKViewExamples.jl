# ## Examples for vtkview

# Load package
using VTKView

# ### Plot 2D rectangular grid
function rectgrid2d(;tend=5,n=50)
    frame=VTKView.StaticFrame()
    clear!(frame)
    X=collect(-1.0:1.0/n:1.0)
    N=length(X)
    dataset=VTKView.DataSet()
    rectilineargrid!(dataset,X,X)
    gridview=VTKView.GridView()
    data!(gridview,dataset)
    addview!(frame,gridview)
    display(frame)
end

# ### Plot  scalar function on 2D rectangular grid
function rectscalar2d(;tend=5,n=50)
    frame=VTKView.StaticFrame()
    X=collect(0:1.0/n:1.0)
    Y=collect(0:1.0/n:1.0)
    Z=zeros(Float64,length(X),length(Y))
    F(x,y,t)=exp(-(x*x+y*y))*sin(t+9.0*x)*cos(11.0*y-2.0*t)
    clear!(frame)
    dataset=VTKView.DataSet()
    scalarview=VTKView.ScalarView()
    layout!(frame,1,1)
    size!(frame,300,300)
    rectilineargrid!(dataset,X,Y) 
    addpointscalar!(dataset,vec(Z),"V")
    data!(scalarview,dataset,"V")
    addview!(frame,scalarview,1)
    for t in 0:0.1:tend
        for i=1:length(X)
            for j=1:length(Y)
                Z[i,j] = F(X[i],Y[j],t)
            end
        end
        addpointscalar!(dataset,vec(Z),"V")
        display(frame)
    end
end



# ### Plot 2D simplex  grid
function simplexgrid2d(;tend=5,n=20)
    frame=VTKView.StaticFrame()
    clear!(frame)
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


# ### Plot scalar function on 2D simplex  grid
function simplexscalar2d(;tend=5,n=50)
    frame=VTKView.StaticFrame()
    clear!(frame)
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
    size!(frame,300,300)
    addpointscalar!(dataset,Z,"V")
    data!(scalarview,dataset,"V")
    addview!(frame,scalarview,1)
    
    for t in 0:0.1:tend
        for i=1:npt
            Z[i]=F(points[:,i]..., t)
        end
        addpointscalar!(dataset,vec(Z),"V")
        display(frame)
    end
end



# ### Plot 3D rectangular grid
function rectgrid3d(;tend=5,n=50)
    frame=VTKView.StaticFrame()
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

# ### Plot scalar function on 3D rectangular grid
function rectscalar3d(;n=50,tend=5)
    frame=VTKView.StaticFrame()
    F(x,y,z,t)=sin((10+sin(t))*x-t)*cos(10y-t)*sin(3z-2t)
    X=collect(-1.0:1.0/n:1.0)
    N=length(X)
    V=[F(X[i],X[j],X[k],0) for i=1:N,j=1:N,k=1:N]
    clear!(frame)
    dataset=VTKView.DataSet()
    scalarview=VTKView.ScalarView()
    size!(frame,500,500)
    rectilineargrid!(dataset,X,X,X) 
    addpointscalar!(dataset,vec(V),"V")
    data!(scalarview,dataset,"V")
    show_isosurfaces!(scalarview,true)
    isolevels!(scalarview,[0.1,0.9])
    addview!(frame,scalarview)

    for t in 0:0.1:tend
        for i=1:N,j=1:N,k=1:N
            V[i,j,k]=F(X[i],X[j],X[k],t)
        end
        frametitle!(frame,"t=$(t)")
        addpointscalar!(dataset,vec(V),"V")
        display(frame)
    end
end



# ### Plot 3D simplex grid
function simplexgrid3d(;tend=5,n=20)
    frame=VTKView.StaticFrame()
    clear!(frame)
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



# ### Plot scalar function on 3D simplex grid
function simplexscalar3d(;tend=5,n=20)
    frame=VTKView.StaticFrame()
    clear!(frame)
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
    addpointscalar!(dataset,Z,"V")
    data!(scalarview,dataset,"V")
    addview!(frame,scalarview,1)
    show_isosurfaces!(scalarview,true)
    isolevels!(scalarview,[0.1,0.9])
    
    for t in 0:0.1:tend
        for i=1:npt
            Z[i]=F(points[:,i]..., t)
        end
        addpointscalar!(dataset,vec(Z),"V")
        display(frame)
    end
end



# ### Multiple views in one figure
function multifig(;tend=5,n=50)
    frame=VTKView.StaticFrame()
    F(x,y,t)=exp(-(x*x+y*y))*sin(t+9.0*x)*cos(11.0*y-2.0*t)
    X=collect(0:1.0/n:1.0)
    Y=collect(0:1.0/n:1.0)

    clear!(frame)
    h=0.01
    X=collect(0:h:1.0)
    Y=collect(0:h:1.2)
    Z=zeros(Float64,length(X),length(Y))
    dataset=VTKView.DataSet()
    scalarview=VTKView.ScalarView()
    layout!(frame,2,1)
    size!(frame,600,300)
    rectilineargrid!(dataset,X,Y) 

    addpointscalar!(dataset,vec(Z),"V")
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
        addpointscalar!(dataset,vec(Z),"V")
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

# ### Run all examples
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
