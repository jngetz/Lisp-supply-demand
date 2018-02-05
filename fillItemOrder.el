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
  (cond ((equal request 0) (list (list (list (caar inventory) nil 0 t)) nil))
	(t (mergeStock (shipStock (addWarehouse (cdr inventory) (updateWarehouse
						(car inventory) request))
		       ;;Pass inventory with first warehouse adjusted and moved
		       ;;to sorted order based on new profit margin
		       (- request (supplyFrom (car inventory) request)))
		       ;;Pass remaining request
		       (car inventory) (supplyFrom (car inventory) request)
		       ;;Pass warehouse and size of shipment to mergeStock
		       (calcNetProfit (car inventory))
		       ;;Pass profit per item
		       )  
	   ;;Pass results of rest of shipment and this shipment (wid and N)
	)
  )
)

;;PRE:  further_shipments is final output type
;;      warehouse is the warehouse we are shipping from
;;      size is the number of items in this shipment
;;      profit is the net profit on an item in this shipment
;;POST: RV = final output type 
(defun mergeStock (further_shipments warehouse size profit)
  (list (list (list (car warehouse)
	      ;;iid
	      (recordShipment (cadr (caar further_shipments)) warehouse size
				    profit)
	      ;;list of shipments
	      (+ (nth 2 (caar further_shipments))
		 (* profit size))
	      ;;total profit for this item thus far
	      t
	      ;;Item is always supplied if we get into this function
	      ) )
	;;item shipment information
	(cond ((= (nth 2 warehouse) (nth 3 warehouse))
		(append (car (cdr further_shipments)) (list (cadr warehouse)
						      (list (car warehouse)))))
	       ;;If MS == CS, then this shipment will put us below MS
	       ;;so we add a warning for this warehouse to warnings
	       (t (cdr further_shipments)))
	       ;;Else, no additional warning necessary, just existing warnings
	;;warehouse warnings
	)
)

;;PRE:  shipments is a list of shipment types
;;      warehouse is the warehouse we are shipping from
;;      size is the number of items in this shipment
;;      profit is the net profit on an item in this shipment
;;POST: RV = a list of shipment types with the current shipment included
(defun recordShipment (shipments warehouse size profit)
  (cond ((equal shipments nil) (list (list (cadr warehouse) size
				   (* profit size))))
	((equal (cadr warehouse) (caar shipments))
	 ;;If wid is the same for this shipment and another shipment
	 (append (list (list (cadr warehouse) (+ (nth 1 (car shipments)) size)
		       ;;wid remains the same, add size to shipment size so far
		       (+ (nth 2 (car shipments)) (* profit size))
		       ;;New warehouse profit
		       ))
		 (cdr shipments))
	 ;;Append updated shipment info from this warehouse to the
	 ;;remainder of the shipments
	 )
	 (t (append  (list (car shipments))
		     (recordShipment (cdr shipments) warehouse size profit)))
	 ;;Not same wid, shipments isn't nil
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
