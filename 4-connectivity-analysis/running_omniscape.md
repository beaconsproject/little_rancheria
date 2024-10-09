Running Omniscape with Julia
2024-10-09

#1 - Install Julia

- Download portable version from https://julialang.org/
- Install it at e.g., "C:/Julia"

#2 - Install Omniscape
- start Julia
- at the prompt type: using Pkg; Pkg.add("Omniscape")

#3 - Run Omniscape

- create a ini file e.g., caribou.ini (see https://docs.circuitscape.org/Omniscape.jl/latest/usage/)
- start Julia
- at the prompt type: run_omniscape("caribou.ini")
- a progress bar will appear to tell you the estimated time of completion
