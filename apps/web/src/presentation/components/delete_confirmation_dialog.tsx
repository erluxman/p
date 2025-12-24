import { Dialog, DialogTitle, DialogContent, DialogActions, Button, Typography } from '@mui/material';

interface DeleteConfirmationDialogProps {
  open: boolean;
  todoTitle: string;
  onConfirm: () => void;
  onCancel: () => void;
}

export const DeleteConfirmationDialog = ({
  open,
  todoTitle,
  onConfirm,
  onCancel,
}: DeleteConfirmationDialogProps) => {
  return (
    <Dialog open={open} onClose={onCancel}>
      <DialogTitle>Delete Todo</DialogTitle>
      <DialogContent>
        <Typography>
          Are you sure you want to delete &quot;{todoTitle}&quot;? This action cannot be undone.
        </Typography>
      </DialogContent>
      <DialogActions>
        <Button onClick={onCancel}>Cancel</Button>
        <Button onClick={onConfirm} color="error" variant="contained">
          Delete
        </Button>
      </DialogActions>
    </Dialog>
  );
};
