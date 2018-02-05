;;PRE:  L is a list
;;POST: RV = N where N is the number of elements in L
(defun length (L)
  (cond ((equal L nil) 0)
	(t (+ (length (cdr L)) 1))
  )
)

;;PRE:  inventory type
;;POST: RV = inventory type sorted in descending order
(defun inventorySort (inventory)
  ;; pass
)

;;PRE:  warehouse which equals (IID WID CS MS CPI PPI)
;;POST: RV = PPI-CPI iff CS < MS, otherwise PPI
(defun calcNetProfit (warehouse)
  (cond ((<= (nth 2 warehouse) (nth 3 warehouse))
	 ;;position 2 is the CS and position 3 is the MS
	 (- (nth 5 warehouse) (nth 4 warehouse)))
	;;position 5 is PPI and position 4 is CPI
	;;Since CS is below MS, the net profit is PPI - CPI
	(t (nth 5 warehouse))
	)
)

;;PRE:  inventory type
;;POST: RV = sum of stock in inventory type
(defun sumStock (inventory)
  (cond ((equal inventory nil) 0)
	(t (+ (sumStock (cdr inventory)) (nth 2 (car inventory))))
	   ;;Element of a warehouse at position 2 is CS
  )
)
