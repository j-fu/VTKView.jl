push!(LOAD_PATH,"../src/")

using Documenter, VTKView, Literate


function make_all()
    makedocs(sitename="VTKView.jl",
             modules = [VTKView],
             doctest = true,
             clean = true,
             authors = "J. Fuhrmann",
             repo="https://github.com/j-fu/VTKView.jl",
             pages=[
                 "Home"=>"index.md",
                 "changes.md",
                 "vizcon2.md",
                 "api.md",
                 "examples.md",
             ])
    
    if !isinteractive()
        deploydocs(repo = "github.com/j-fu/VTKView.jl.git")
    end
end


make_all()


