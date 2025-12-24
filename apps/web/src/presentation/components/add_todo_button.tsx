import { Button } from '@mui/material';
import { Add as AddIcon } from '@mui/icons-material';

interface AddTodoButtonProps {
  onClick: () => void;
}

export const AddTodoButton = ({ onClick }: AddTodoButtonProps) => {
  return (
    <Button
      variant="contained"
      startIcon={<AddIcon />}
      onClick={onClick}
      sx={{ mb: 2 }}
    >
      Add Todo
    </Button>
  );
};
