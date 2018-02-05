(load-file "helper.el")

;;PRE:  inventory as inventory type
;;      item_demand is a pair (IID R) where R is the number of items requested
;;POST: RV = final output type
(defun fillItemOrder (inventory item_demand)
  (cond
    ((< (sumStock (getWarehouses (car item_demand))) (car (last item_demand))) '((((car item_demand) () 0 nil)) ()))
    (t (shipStock (getWarehouses (car item_demand)) (car (last item_demand))))
  )
)

;;PRE:  iid exists in the inventory type and inventory is inventory type
;;POST: RV = inventory type where all IID = iid
(defun getWarehouses (iid inventory)
  (getWarehousesHelper iid inventory nil)
)

;;PRE:  the iid to include, inventory type to read from, basis for the building
;;      of the RV
;;POST: RV = inventory type where all IID = iid
(defun getWarehousesHelper (iid inventory basis)
  (cond
    ((equal inventory nil) basis)
    ((equal iid (car (car inventory))) (getWarehousesHelper iid (cdr inventory) (addWarehouse basis (car inventory))))
    (t (getWarehousesHelper iid (cdr inventory) basis))
  )
)

;;PRE:  inventory type and a warehouse which equals (IID WID CS MS CPI PPI)
;;      inventory does not contain a copy of warehouse
;;POST: RV = inventory type where warehouse is in inventory and inventory is
;;      sorted in descending order of net profit on next sale
(defun addWarehouse (inventory warehouse)
  (cond
    ((equal inventory nil) (append inventory (list warehouse)))
    ((> (calcNetProfit warehouse) (calcNetProfit (car inventory))) (append (list warehouse) inventory))
    (t (append (list (car inventory)) (addWarehouse (cdr inventory) warehouse)))
  )
)

;;PRE:  inventory type and request, the number of items requested
;;POST: RV = final output type
(defun shipStock (inventory request)
  (shipStockHelper inventory request '(() ())) ; empty f.o.t. passed in
)

;;PRE:  inventory type, number of items requested, basis is final output type list to build into
;;POST: RV = final output type
(defun shipStockHelper (inventory request basis)
  (cond
    ((equal request 0) basis) ; when the request is filled return the built basis list
    (t (shipStockHelper (addWarehouse (cdr inventory) (updateWarehouse (car inventory) N)) (- N (supplyFrom (car inventory) N)) (list (append ## (car basis)) (append ## (last basis))))) ;TODO: finish the recursive call
  )
)

;;PRE:  the warehouse needing to be updated and the current N being worked with
;;POST: a 6-tuple (IID WID CS MS CPI PPI) where CS is updated to CS - min(CS, N)
;;      iff CS <= MS, otherwise CS updated to CS - min(CS-MS, N)
(defun updateWarehouse (warehouse N)
  (cond
    ((> (nth 2 warehouse) (nth 3 warehouse)) (append (list (nth 0 warehouse) (nth 1 warehouse) (- (nth 2 warehouse) (min (- (nth 2 warehouse) (nth 3 warehouse)) N))) (nthcdr 3 warehouse)))
    (t (append (list (nth 0 warehouse) (nth 1 warehouse) (- (nth 2 warehouse) (min (nth 2 warehouse) N))) (nthcdr 3 warehouse)))
  )
)

;;PRE:  warehouse we are extracting from and the current N
;;POST: the number of items taken from the warehouse
(defun supplyFrom (warehouse N)
  (cond
    ((> (nth 2 warehouse) (nth 3 warehouse)) (min (- (nth 2 warehouse) (nth 3 warehouse)) N))
    (t (min (nth 2 warehouse) N))
  )
)
