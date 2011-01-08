module InSubProcess
  def in_sub_process
    readme, writeme = IO.pipe

    pid = Process.fork do
      readme.close
      writeme.write yield
      writeme.close
    end

    writeme.close
    Process.waitpid(pid)
    return_val = readme.read
    readme.close

    return_val
  end
end
