push!(LOAD_PATH,"../src/")

using Documenter, VTKView, Literate


function make_all()
    #
    # Generate Markdown pages from examples
    #
    example_jl_dir = joinpath(@__DIR__,"..","examples")
    example_md_dir  = joinpath(@__DIR__,"src","examples")
    
    for example_source in readdir(example_jl_dir)
        base,ext=splitext(example_source)
        if ext==".jl"
            Literate.markdown(joinpath(@__DIR__,"..","examples",example_source),
                              example_md_dir,
                              documenter=false,
                              info=false)
        end
    end
    generated_examples=joinpath.("examples",readdir(example_md_dir))
    
    

    makedocs(sitename="VTKView.jl",
             modules = [VTKView],
             doctest = true,
             clean = true,
             authors = "J. Fuhrmann",
             repo="https://github.com/j-fu/VTKView.jl",
             pages=[
                 "Home"=>"index.md",
                 "changes.md",
                 "api.md",
                 "Examples" => generated_examples
             ])
    rm(example_md_dir,recursive=true)
    
    if !isinteractive()
        deploydocs(repo = "github.com/j-fu/VTKView.jl.git")
    end
end


make_all()


