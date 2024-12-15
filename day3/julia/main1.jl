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
sent = ""
isEnabled = true
accum = 0
regex = r"mul\(([0-9]{1,3}),([0-9]{1,3})\)"
rm("pdata")
open("pdata","w") do fh 
  for line in eachline("InputData")
    sent = replace(line,")"=>")\n")
    write(fh,sent)
  end
end

for line in eachline("pdata")
  if(contains(line,"don't()"))
    global isEnabled = false
    @info("Inside Dont ",line)
  elseif(contains(line,"do()"))
    global isEnabled = true
  end
  @info(isEnabled)
  for match in eachmatch(regex,line)
    @info(match)
    if(isEnabled == true)
      global accum += parse(Int64,match[1]) * parse(Int64,match[2])
    end
  end
end

println("The Answer is :", accum)
if(logging == true)
  close(logging_io)
end

