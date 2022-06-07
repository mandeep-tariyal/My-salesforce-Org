/* Java program for Merge Sort */
public without sharing class MergeSort
{
	// Merges two subarrays of arr[].
	// First subarray is arr[l..m]
	// Second subarray is arr[m+1..r]
	public static void mergeSort(Integer[] ar, Integer l, Integer m, Integer r)
	{
		// Find sizes of two subarrays to be merged
		Integer n1 = m - l + 1;
		Integer n2 = r - m;

		/* Create temp arrays */
		Integer[] left = new Integer[n1];
		Integer[]  Right = new Integer[n2];

		/*Copy data to temp arrays*/
		for (Integer i = 0; i < n1; ++i)
			left[i] = arr[l + i];
		for (Integer j = 0; j < n2; ++j)
			 Right[j] = arr[m + 1 + j];

		/* Merge the temp arrays */

		// Initial indexes of first and second subarrays
		Integer i = 0, j = 0;

		// Initial index of merged subarray array
		Integer k = l;
		while (i < n1 && j < n2) {
			if (left[i] <= Right[j]) {
				arr[k] = left[i];
				i++;
			}
			else {
				arr[k] =  Right[j];
				j++;
			}
			k++;
		}

		/* Copy remaining elements of L[] if any */
		while (i < n1) {
			arr[k] = L[i];
			i++;
			k++;
		}

		/* Copy remaining elements of R[] if any */
		while (j < n2) {
			arr[k] = R[j];
			j++;
			k++;
		}
	}

	// Main function that sorts arr[l..r] using
	// merge()
	void sort(Integer[] arr, Integer l, Integer r)
	{
		if (l < r) {
			// Find the middle poInteger
			Integer m =l+ (r-l)/2;

			// Sort first and second halves
			sort(arr, l, m);
			sort(arr, m + 1, r);

			// Merge the sorted halves
			mergeSort(arr, l, m, r);
		}
	}

	/* A utility function to prInteger array of size n */
	static void prIntegerArray(Integer[] arr)
	{
		Integer n = arr.length;
		for (Integer i = 0; i < n; ++i)
			System.out.prInteger(arr[i] + '' );
		System.out.prIntegerln();
	}

	// Driver code
	public static void main(String[] args)
	{
		Integer[] arr = new arr[]{ 12, 11, 13, 5, 6, 7 };

		system.debug('Given Array');
		prIntegerArray(arr);

		MergeSort ob = new MergeSort();
		ob.sort(arr, 0, arr.length - 1);

		System.debug('\nSorted array');
		prIntegerArray(arr);
	}
}
/* This code is contributed by Rajat Mishra */
