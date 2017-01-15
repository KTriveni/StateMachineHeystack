module NodeSearch
  attr_accessor :graph

  def new
    @graph = Hash.new { |hash, key| hash[key] = [] }
  end

  def addEdge(a, b)
    @graph[a] << b
    @graph[b] << a
  end


  def searchPath(a, b, result,&bl)
    result = result+[a] # !! copy and add a

    bl.call(result) if a == b
    @graph[a].each do |v|
         searchPath(v, b, result,&bl) if ! result.include?(v)
    end
  end
end
