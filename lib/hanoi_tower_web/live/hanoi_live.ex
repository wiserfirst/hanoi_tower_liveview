defmodule HanoiTowerWeb.HanoiLive do
  use Phoenix.LiveView
  alias HanoiTowerWeb.HanoiView

  @default_disk_count 3

  def mount(_session, socket) do
    {:ok, assign(socket, initial_state(@default_disk_count))}
  end

  def render(assigns) do
    HanoiView.render("hanoi.html", assigns)
  end

  def handle_event("disk-num", %{"disk-count" => disk_count_str}, socket) do
    with {disk_count, ""} <- Integer.parse(disk_count_str),
         true <- valid_count?(disk_count) do
      {:noreply, assign(socket, initial_state(disk_count))}
    else
      _ -> {:noreply, socket}
    end
  end

  def handle_event(
        "move-disk",
        %{"from" => from_rod_no, "to" => to_rod_no},
        %{assigns: state} = socket
      ) do
    new_state = update_disks(state, from_rod_no, to_rod_no)
    {:noreply, assign(socket, new_state)}
  end

  defp valid_count?(count) when count > 0 and count <= 7, do: true
  defp valid_count?(_), do: false

  defp initial_state(disk_count) do
    %{
      first_rod: Enum.to_list(1..disk_count),
      second_rod: [],
      third_rod: [],
      marked: nil,
      disk_count: disk_count,
      time_elapsed: "00:00:00"
    }
  end

  defp update_disks(state, from_rod_no, to_rod_no) do
    from_rod_key = get_rod_key(from_rod_no)
    to_rod_key = get_rod_key(to_rod_no)

    if can_move_disk?(state[from_rod_key], state[to_rod_key]) do
      state
      |> Map.update!(from_rod_key, &tl/1)
      |> Map.update!(to_rod_key, fn current -> [hd(state[from_rod_key]) | current] end)
    else
      state
    end
  end

  defp get_rod_key("1"), do: :first_rod
  defp get_rod_key("2"), do: :second_rod
  defp get_rod_key("3"), do: :third_rod

  defp can_move_disk?([], _to_rod), do: false
  defp can_move_disk?(_from_rod, []), do: true
  defp can_move_disk?([from_top | _], [to_top | _]), do: from_top < to_top
end
