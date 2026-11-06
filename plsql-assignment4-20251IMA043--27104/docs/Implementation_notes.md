# Implementation & Performance Notes

## Implementation of PL/SQL Requirements
1. **Records**: User-defined records (`t_student_eval`) and `%ROWTYPE` attributes used.
2. **Collections**: Nested tables implemented for memory collection.
3. **Cursors**: Implicit cursor attributes (`SQL%ROWCOUNT`) and explicit cursor loops (`OPEN`, `FETCH`, `CLOSE`) utilized.
4. **Bulk Processing**: `BULK COLLECT` and `FORALL` with `SAVE EXCEPTIONS` implemented.

## Performance Analysis
- **Bulk Processing**: Reduces context switches to a single batch call, significantly boosting efficiency.