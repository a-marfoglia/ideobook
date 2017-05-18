class Array
  def b_insert(new_elm)
    if self.empty?
      self.append(new_elm)
    else
      index = self.bsearch_index{|x, _| x > new_elm}
      if index == nil
        self.append(new_elm)
      else
        self.insert(index, new_elm)
      end
    end
  end

  def b_search (key)  # a is the array and key is the value to be found
      lo = 0
      hi= self.length-1

      while (lo<=hi)
          mid = lo+((hi-lo)/2)

          if self[mid] == key
              return mid
          elsif self[mid] < key
              lo=mid+1
          else
              hi=mid-1
          end

      end

      return nil
  end
end
