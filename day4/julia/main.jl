using PrettyTables
# Get the data from the file 
begin
  #Global Variables declared here
  search_string = "XMAS"
  kern = nothing
  #Global Variables declaration ends
  #
  using Logging
  logging = false
  logging_io = nothing
  if(isfile("log.txt"))
    rm("log.txt")
  end
  function setlogger(set::Bool,close::Bool)
    if(logging && set==true)
      io = open("log.txt", "w+")
      logger = SimpleLogger(io)
      global_logger(logger)
      global logging_io = io
      return nothing
    elseif(logging && close==true)
      close(logging_io)
    end
  end
  setlogger(true,false)

  needle = collect(search_string)
  function check_non_matching()
    for line in eachline("ExampleData")
      linearr = collect.(line)
      chk = in(in.(linearr,Ref(needle)),0)
      if(chk !=0)
        @info(line)
        return false
      end
    end
    return true
  end

  function construct_kernel(str)
    matrix_size = 2 * length(str) - 1 
    kernel = Array{String}(undef,matrix_size,matrix_size)

    mpx = length(str)
    mpy = length(str)
    for (idx,val) in enumerate(str)
      if(idx == 1)
        kernel[mpx,mpy] = string(val)
      else
        @info("Idx:",idx)
        @info("Calc:",mpx-idx+1)
        kernel[mpx+idx-1,mpy] = string(val) #Right fill
        kernel[mpx-idx+1,mpy] = string(val) #Left fill
        kernel[mpx,mpy+idx-1] = string(val) #Top fill
        kernel[mpx+idx-1,mpy+idx-1] = string(val) #Top Right fill
        kernel[mpx+idx-1,mpy-idx+1] = string(val) #Bottom Right fill
        kernel[mpx-idx+1,mpy-idx+1] = string(val) #Bottom Left fill
        kernel[mpx-idx+1,mpy+idx-1] = string(val) #Top Left fill
      end
    end

    return kernel
  end

  if(check_non_matching())
    global kern = construct_kernel(search_string)
    pretty_table(kern)
  end
  # Close the logger
  if(logging == true)
    close(logging_io)
  end
end 
