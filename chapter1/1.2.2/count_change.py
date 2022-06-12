def inclusive_range(n):
	return [i for i in range(n+1)]

def main():
	result_list = []
	for one in inclusive_range(100):
		for five in inclusive_range(20):
			for ten in inclusive_range(10):
				for twentyfive in inclusive_range(4):
					for fifty in inclusive_range(2):
						if (1*one + 5*five + 10*ten + 25*twentyfive + 50*fifty) == 20:
							result_list += [[one, five, ten, twentyfive, fifty]]
							print(f"{fifty} {twentyfive} {ten} {five} {one}")
	print(len(result_list))


if __name__ == '__main__':
	main()



