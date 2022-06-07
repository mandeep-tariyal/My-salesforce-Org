public without sharing  class MergeSort
{
	public static void mergeS(list<integer> a, list<integer> l, list<integer> r, Integer left, Integer right) {
 
		System.debug('mergeSort Called');
    Integer i = 0, j = 0, k = 0;
    while (i < left && j < right) {
        if (l[i] <= r[j]) {
            a[k++] = l[i++];
        }
        else {
            a[k++] = r[j++];
        }
    }
    while (i < left) {
        a[k++] = l[i++];
    }
    while (j < right) {
        a[k++] = r[j++];
    }
}

	
	public static void mergeSort(list<integer> a, Integer n) {
		if (n < 2) {
			return;
		}
		Integer mid = n / 2;
		list<integer> l = new Integer[mid];
		list<integer> r = new Integer[n - mid];
	
		for (Integer i = 0; i < mid; i++) {
			l[i] = a[i];
		}
		for (Integer i = mid; i < n; i++) {
			r[i - mid] = a[i];
		}
		System.debug('l'+l);
		mergeSort(l, mid);
		System.debug('l'+l);
		mergeSort(r, n - mid);
		System.debug('r'+ r);
		
		mergeS(a, l, r, mid, n - mid);
	}




	// Driver code
	public static list<integer> driverMethod(List<Integer> arr,Integer size)
	{
		
		List<integer> arrayl = arr;
		system.debug('Given Array');
		
		MergeSort.mergeSort(arrayl,size);

		System.debug('\nSorted array');
        return arrayl;
	}
    
}