# @abstract Controls the running ds-server or ss-server processes.
class Darksocks
  def start(profile); end

  def stop(profile); end

  def running?(profile); end

  private

  def make_config(profile); end

  def read_pid(file); end
end
