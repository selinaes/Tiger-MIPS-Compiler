functor IntMapTable (type key
		     val getInt: key -> int) : TABLE =
struct
  type key=key
  type 'a table = 'a IntBinaryMap.map
  val empty = IntBinaryMap.empty
  fun enter(t,k,a) = IntBinaryMap.insert(t,getInt k,a)
  fun look(t,k) = IntBinaryMap.find(t,getInt k)
  fun listItems(t) = IntBinaryMap.listItems t
  fun listItemsi(t) = IntBinaryMap.listItemsi t
  fun appi f m = IntBinaryMap.appi f m
end
