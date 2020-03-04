module Examples

using VTKView

function rectcontour2d(;tend=5,n=50)
    frame=VTKView.StaticFrame()
    X=collect(0:1.0/n:1.0)
    Y=collect(0:1.0/n:1.0)
    Z=zeros(Float64,length(X),length(Y))
    F(x,y,t)=exp(-(x*x+y*y))*sin(t+9.0*x)*cos(11.0*y-2.0*t)

    clear!(frame)
    griddata=VTKView.DataSet()
    contour=VTKView.ScalarView()
    layout!(frame,1,1)
    size!(frame,300,300)
    rectilineargrid!(griddata,X,Y) 
    pointscalar!(griddata,vec(Z),"V")
    data!(contour,griddata,"V")
    add!(frame,contour,1)
    
    for t in 0:0.1:tend
        for i=1:length(X)
            for j=1:length(Y)
                Z[i,j] = F(X[i],Y[j],t)
            end
        end
        pointscalar!(griddata,vec(Z),"V")
        display(frame)
    end
end



function simplexgrid2d(;tend=5,n=20)
    frame=VTKView.StaticFrame()
    clear!(frame)
    raster=100
    npt=n*n
    inpoints=hcat(unique([ Cdouble[rand(1:raster)/raster, rand(1:raster)/raster] for i in 1:npt])...)
    (points,cells)=VTKView.delaunay(inpoints)
    griddata=VTKView.DataSet()
    simplexgrid!(griddata,points,cells)
    gridview=VTKView.GridView()
    data!(gridview,griddata)
    add!(frame,gridview)
    display(frame)
end


function simplexcontour2d(;tend=5,n=50)
    frame=VTKView.StaticFrame()
    clear!(frame)
    raster=100
    npt=n*n
    inpoints=hcat(unique([ Cdouble[rand(1:raster)/raster, rand(1:raster)/raster] for i in 1:npt])...)
    (points,cells)=VTKView.delaunay(inpoints)

    npt=size(points,2)
    Z=zeros(Float64,npt)


    F(x,y,t)=exp(-(x*x+y*y))*sin(t+9.0*x)*cos(11.0*y-2.0*t)
    
    griddata=VTKView.DataSet()
    simplexgrid!(griddata,points,cells)

    contour=VTKView.ScalarView()
    layout!(frame,1,1)
    size!(frame,300,300)
    pointscalar!(griddata,Z,"V")
    data!(contour,griddata,"V")
    add!(frame,contour,1)
    
    for t in 0:0.1:tend
        for i=1:npt
            Z[i]=F(points[:,i]..., t)
        end
        pointscalar!(griddata,vec(Z),"V")
        display(frame)
    end
end




function simplexgrid3d(;tend=5,n=20)
    frame=VTKView.StaticFrame()
    clear!(frame)
    raster=100
    npt=n*n*n
    inpoints=hcat(unique([ Cdouble[rand(1:raster)/raster, rand(1:raster)/raster,rand(1:raster)/raster] for i in 1:npt])...)
    (points,cells)=VTKView.delaunay(inpoints)
    griddata=VTKView.DataSet()
    simplexgrid!(griddata,points,cells)
    gridview=VTKView.GridView()
    data!(gridview,griddata)
    add!(frame,gridview)
    display(frame)
end



function simplexcontour3d(;tend=5,n=20)
    frame=VTKView.StaticFrame()
    clear!(frame)
    raster=100
    npt=n*n*n
    inpoints=hcat(unique([ Cdouble[rand(1:raster)/raster, rand(1:raster)/raster, rand(1:raster)/raster] for i in 1:npt])...)
    (points,cells)=VTKView.delaunay(inpoints)

    npt=size(points,2)
    Z=zeros(Float64,npt)


    F(x,y,z,t)=sin((10+sin(t))*x-t)*cos(10y-t)*sin(3z-2t)
    
    griddata=VTKView.DataSet()
    simplexgrid!(griddata,points,cells)

    contour=VTKView.ScalarView()
    layout!(frame,1,1)
    size!(frame,500,500)
    pointscalar!(griddata,Z,"V")
    data!(contour,griddata,"V")
    add!(frame,contour,1)
    show_isosurfaces!(contour,true)
    isolevels!(contour,[0.1,0.9])
    
    for t in 0:0.1:tend
        for i=1:npt
            Z[i]=F(points[:,i]..., t)
        end
        pointscalar!(griddata,vec(Z),"V")
        display(frame)
    end
end




function rectgrid2d(;tend=5,n=50)
    frame=VTKView.StaticFrame()
    clear!(frame)
    X=collect(-1.0:1.0/n:1.0)
    N=length(X)
    griddata=VTKView.DataSet()
    rectilineargrid!(griddata,X,X)
    gridview=VTKView.GridView()
    data!(gridview,griddata)
    add!(frame,gridview)
    display(frame)
end

function rectgrid3d(;tend=5,n=50)
    frame=VTKView.StaticFrame()
    clear!(frame)
    X=collect(-1.0:1.0/n:1.0)
    N=length(X)
    griddata=VTKView.DataSet()
    rectilineargrid!(griddata,X,X,X)
    gridview=VTKView.GridView()
    data!(gridview,griddata)
    add!(frame,gridview)
    display(frame)
end




function rectcontour3d(;n=50,tend=5)
    frame=VTKView.StaticFrame()
    F(x,y,z,t)=sin((10+sin(t))*x-t)*cos(10y-t)*sin(3z-2t)
    X=collect(-1.0:1.0/n:1.0)
    N=length(X)
    V=[F(X[i],X[j],X[k],0) for i=1:N,j=1:N,k=1:N]
    clear!(frame)
    griddata=VTKView.DataSet()
    contour=VTKView.ScalarView()
    size!(frame,500,500)
    rectilineargrid!(griddata,X,X,X) 
    pointscalar!(griddata,vec(V),"V")
    data!(contour,griddata,"V")
    show_isosurfaces!(contour,true)
    isolevels!(contour,[0.1,0.9])
    add!(frame,contour)

    for t in 0:0.1:tend
        for i=1:N,j=1:N,k=1:N
            V[i,j,k]=F(X[i],X[j],X[k],t)
        end
        frametitle!(frame,"t=$(t)")
        pointscalar!(griddata,vec(V),"V")
        display(frame)
    end
end



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
    griddata=VTKView.DataSet()
    contour=VTKView.ScalarView()
    layout!(frame,2,1)
    size!(frame,600,300)
    rectilineargrid!(griddata,X,Y) 

    pointscalar!(griddata,vec(Z),"V")
    data!(contour,griddata,"V")
    add!(frame,contour,1)

    plot=VTKView.XYPlot()
    add!(frame,plot,2)
    
    for t in 0:0.1:tend
        for i=1:length(X)
            for j=1:length(Y)
                Z[i,j] = F(X[i],Y[j],t)
            end
        end
        pointscalar!(griddata,vec(Z),"V")
        clear!(plot)
        plotlegend!(plot,"j=1")
        plotcolor!(plot,1,0,0)
        add!(plot,X,Z[:,1])

        plotcolor!(plot,0,0,1)
        plotlegend!(plot,"i=1")
        add!(plot,Y,Z[1,:])

        display(frame)
    end
    write_png(frame,"multifig.png")
    write_vtk(griddata,"multifig.vtk")
end

function all()
    rectgrid2d()
    rectcontour2d()
    rectgrid3d()
    rectcontour3d()

    simplexgrid2d()
    simplexcontour2d()
    simplexgrid3d()
    simplexcontour3d()
    multifig()
end
end
