class Node(object):
	def __init__(self,key,data=None):
		self.key = key
		self.data = data
		self.children = {}


class Trie(object):

	def __init__(self):
		self.head = Node(None)

	"""
	Trie에 문자열을 삽입합니다.
	terminal 노드일 경우에는 data에 string을 저장합니다.
	"""
	def insert(self,string):
		curr_node = self.head

		# 문자열 하나하나를 돌면서
		for s in string:
			if s not in curr_node.children:
				child = Node(s)
				curr_node.children[s] = Node(s)
			curr_node = curr_node.children[s]
		curr_node.data = string

	"""
	해당 query로 시작하는 문자열의 갯수를 리턴합니다.
	"""
	def startswith(self,query):
		cnt = 0 # 문자열의 갯수
		curr_node = self.head
		candidate = None
		for q in query:
			if q not in curr_node.children:
				return cnt
			else:
				curr_node = curr_node.children[q]
				candidate = curr_node


		# candidate는 query의 마지막 글자가 들어간 노드
		# 이제 이 노드에서 부터 BFS로 순환하면서 data != None인 terminal 노드의 갯수를 찾는다

		queue = list(candidate.children.values())

		while queue:
			nde = queue.pop()
			if nde.data != None:
				cnt += 1
			queue += list(nde.children.values())

		return cnt


if __name__ == "__main__":
	trie = Trie()
	trie.insert("june")
	trie.insert("jj")
	trie.insert("hb")
	print(trie.startswith("ju"))
