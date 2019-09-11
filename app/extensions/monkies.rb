# 
# Hash monkeypatch
# 
# @author matt.wiater@roundhouseagency.com
# 
class Hash
  # 
  # Deep hash merge for nested hashes
  # @param hashToMerge [type] [description]
  # 
  # @return Hash of merged hashes
  def deep_merge(hashToMerge)
    merger = proc { |key, v1, v2| Hash === v1 && Hash === v2 ? v1.merge(v2, &merger) : Array === v1 && Array === v2 ? v1 | v2 : [:undefined, nil, :nil].include?(v2) ? v1 : v2 }
    self.merge(hashToMerge.to_h, &merger)
  end
end